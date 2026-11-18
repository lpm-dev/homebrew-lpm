#!/bin/bash
# Runs scripts/verify-dispatched-release.sh against stub `gh` and `cosign`
# commands that serve one signed release, and checks what it accepts.

set -euo pipefail

repo_root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd -P)
script="$repo_root/scripts/verify-dispatched-release.sh"
root=$(mktemp -d)
trap 'rm -rf "$root"' EXIT HUP INT TERM

commit=1e98fb8efbcc00f620678fc8091b512ed503768f
darwin_arm64=1111111111111111111111111111111111111111111111111111111111111111
darwin_x64=2222222222222222222222222222222222222222222222222222222222222222
linux_arm64=3333333333333333333333333333333333333333333333333333333333333333
linux_x64=4444444444444444444444444444444444444444444444444444444444444444

mkdir "$root/bin" "$root/release"
printf '%s  %s\n' \
  "$darwin_arm64" lpm-darwin-arm64.zip \
  "$darwin_x64" lpm-darwin-x64.zip \
  "$linux_arm64" lpm-linux-arm64 \
  "$linux_x64" lpm-linux-x64 \
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa lpm-win32-x64.exe \
  > "$root/release/SHA256SUMS.txt"
printf 'bundle' > "$root/release/SHA256SUMS.txt.sigstore"

cat > "$root/bin/gh" <<'GH'
#!/bin/bash
set -euo pipefail
case "$1" in
  api)
    printf '%s\t%s\t%s\n' "${STUB_DRAFT:-false}" "${STUB_PRERELEASE:-false}" "${STUB_COMMIT}"
    ;;
  release)
    shift 2
    dir=
    while [ "$#" -gt 0 ]; do
      case "$1" in
        --dir) dir=$2; shift 2 ;;
        *) shift ;;
      esac
    done
    cp "$STUB_RELEASE"/SHA256SUMS.txt "$STUB_RELEASE"/SHA256SUMS.txt.sigstore "$dir"/
    ;;
  *) exit 99 ;;
esac
GH
cat > "$root/bin/cosign" <<'COSIGN'
#!/bin/sh
printf '%s\n' "$@" > "$STUB_COSIGN_ARGS"
[ -z "${STUB_COSIGN_REFUSES:-}" ]
COSIGN
chmod +x "$root/bin/gh" "$root/bin/cosign"

run() {
  env PATH="$root/bin:$PATH" STUB_RELEASE="$root/release" STUB_COSIGN_ARGS="$root/cosign-args" \
    STUB_COMMIT="${STUB_COMMIT:-$commit}" VERSION=0.88.0 \
    SHA_DARWIN_ARM64="$darwin_arm64" SHA_DARWIN_X64="$darwin_x64" \
    SHA_LINUX_ARM64="$linux_arm64" SHA_LINUX_X64="$linux_x64" \
    "$@" bash "$script" >"$root/out" 2>&1
}

refuses() {
  local reason=$1
  shift
  rm -f "$root/cosign-args"
  if run "$@"; then
    echo "verify-dispatched-release.sh accepted $reason" >&2
    cat "$root/out" >&2
    exit 1
  fi
}

run || { cat "$root/out" >&2; echo "a dispatch matching the signed release was refused" >&2; exit 1; }
cosign_args=$(tr '\n' ' ' < "$root/cosign-args")
for expected in \
  "--certificate-identity https://github.com/lpm-dev/rust-client/.github/workflows/release.yml@refs/heads/main " \
  "--certificate-github-workflow-repository lpm-dev/rust-client " \
  "--certificate-github-workflow-ref refs/heads/main " \
  "--certificate-github-workflow-sha $commit " \
  "--certificate-github-workflow-trigger workflow_dispatch "
do
  case "$cosign_args" in
    *"$expected"*) ;;
    *) echo "cosign check is missing '$expected': $cosign_args" >&2; exit 1 ;;
  esac
done

refuses "a checksum the release didn't sign" SHA_LINUX_X64=5555555555555555555555555555555555555555555555555555555555555555
refuses "a signature cosign refused" STUB_COSIGN_REFUSES=1
refuses "a draft release" STUB_DRAFT=true
refuses "a prerelease" STUB_PRERELEASE=true
refuses "a release without a recorded commit" STUB_COMMIT=main
refuses "a version with a leading v" VERSION=v0.88.0
refuses "a nightly version" VERSION=0.88.0-nightly.20261118.1.abcdef0
refuses "a missing checksum" SHA_DARWIN_X64=
if [ -e "$root/cosign-args" ]; then
  echo "cosign ran for a malformed dispatch" >&2
  exit 1
fi

printf '%s  %s\n' "$linux_x64" lpm-linux-x64 >> "$root/release/SHA256SUMS.txt"
refuses "a manifest that lists an asset twice"

echo "verify-dispatched-release.sh accepts only checksums the release signed"
