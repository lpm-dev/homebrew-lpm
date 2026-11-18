#!/bin/bash
# Verifies the release an update dispatch names before the formula is
# rendered: it must be a published stable release of lpm-dev/rust-client,
# its SHA256SUMS.txt must be signed by the stable release identity at the
# release's commit, and each dispatched checksum must be the signed one.
# A token that can send the dispatch can then only point the formula at a
# release the rust-client release workflow signed.

set -euo pipefail

repository=lpm-dev/rust-client

for name in VERSION SHA_DARWIN_ARM64 SHA_DARWIN_X64 SHA_LINUX_ARM64 SHA_LINUX_X64; do
  if [ -z "${!name:-}" ]; then
    echo "$name is required" >&2
    exit 1
  fi
done
if [[ ! "$VERSION" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]]; then
  echo "VERSION must be a stable semantic version without a leading v" >&2
  exit 1
fi
tag="v$VERSION"

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

release_state=$(gh api "repos/$repository/releases/tags/$tag" \
  --jq '[.draft, .prerelease, .target_commitish] | @tsv')
IFS=$'\t' read -r draft prerelease commit <<<"$release_state"
if [ "$draft" != false ] || [ "$prerelease" != false ]; then
  echo "$tag is not a published stable release of $repository" >&2
  exit 1
fi
if [[ ! "$commit" =~ ^[0-9a-f]{40}$ ]]; then
  echo "$tag does not record the commit it was published from: $commit" >&2
  exit 1
fi

gh release download "$tag" --repo "$repository" --dir "$work" \
  --pattern SHA256SUMS.txt --pattern SHA256SUMS.txt.sigstore

cosign verify-blob \
  --bundle "$work/SHA256SUMS.txt.sigstore" \
  --certificate-identity "https://github.com/$repository/.github/workflows/release.yml@refs/heads/main" \
  --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' \
  --certificate-github-workflow-repository "$repository" \
  --certificate-github-workflow-ref refs/heads/main \
  --certificate-github-workflow-sha "$commit" \
  --certificate-github-workflow-trigger workflow_dispatch \
  "$work/SHA256SUMS.txt"

require_signed_checksum() {
  local asset=$1
  local dispatched=$2
  local signed
  signed=$(awk -v asset="$asset" '$2 == asset { print $1; count++ } END { if (count != 1) exit 1 }' \
    "$work/SHA256SUMS.txt") || {
    echo "SHA256SUMS.txt of $tag must list $asset exactly once" >&2
    exit 1
  }
  if [ "$signed" != "$dispatched" ]; then
    echo "The dispatched checksum of $asset ($dispatched) is not the one $tag signed ($signed)" >&2
    exit 1
  fi
}

require_signed_checksum lpm-darwin-arm64.zip "$SHA_DARWIN_ARM64"
require_signed_checksum lpm-darwin-x64.zip "$SHA_DARWIN_X64"
require_signed_checksum lpm-linux-arm64 "$SHA_LINUX_ARM64"
require_signed_checksum lpm-linux-x64 "$SHA_LINUX_X64"

echo "Verified the dispatched checksums against the signed manifest of $tag ($commit)."
