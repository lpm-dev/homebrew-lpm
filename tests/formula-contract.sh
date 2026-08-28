#!/bin/sh
set -eu

repo_root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd -P)
formula="$repo_root/Formula/lpm.rb"
workflow="$repo_root/.github/workflows/update-formula.yml"
ci_workflow="$repo_root/.github/workflows/ci.yml"
renderer="$repo_root/scripts/render-formula.rb"
template="$repo_root/templates/lpm.rb.erb"

# The checked-in formula must use the signed macOS app bundles published for
# its exact version. Release dispatches render this same bundle-aware contract.
grep -q 'lpm-darwin-arm64.zip' "$formula"
grep -q 'lpm-darwin-x64.zip' "$formula"
grep -q 'using: :nounzip' "$formula"
grep -q 'LPM CLI.app' "$formula"
grep -Fq 'assert_match "lpm #{version}"' "$formula"
grep -Fq 'bin.install_symlink "lpm" => "lpx"' "$formula"

grep -q 'lpm-darwin-arm64.zip' "$template"
grep -q 'lpm-darwin-x64.zip' "$template"
grep -q 'using: :nounzip' "$template"
grep -q 'LPM CLI.app' "$template"
grep -q '/usr/bin/ditto' "$template"
grep -q 'Contents/MacOS/lpm-rs' "$template"
grep -q 'Contents/CodeResources' "$template"
grep -q 'install_symlink' "$template"
grep -q 'TeamIdentifier=823S8YKMRW' "$template"
grep -q '823S8YKMRW.dev.lpm.vault.shared' "$template"
grep -q '823S8YKMRW.\*' "$template"
grep -q 'embedded.provisionprofile' "$template"
grep -q '"/usr/bin/openssl", "smime", "-verify", "-noverify"' "$template"
if grep -q '"/usr/bin/security", "cms"' "$template"; then
  echo "formula template depends on a default Keychain inside the Homebrew sandbox" >&2
  exit 1
fi
grep -q 'com.apple.application-identifier' "$template"
grep -q 'Entitlements:application-identifier' "$template"
grep -q '"/usr/bin/xcrun", "stapler", "validate"' "$template"
if grep -q '"/usr/bin/stapler"' "$template"; then
  echo "formula template invokes a nonexistent stapler path" >&2
  exit 1
fi
grep -q 'unexpected file inventory' "$template"
grep -q 'ruby scripts/render-formula.rb' "$workflow"
grep -q 'run-name: Update lpm.*correlation_id' "$workflow"
grep -q 'CORRELATION_ID:' "$workflow"
if grep -q 'cat > Formula/lpm.rb' "$workflow"; then
  echo "workflow still interpolates dispatch data into a shell heredoc" >&2
  exit 1
fi

grep -q 'pull_request:' "$ci_workflow"
grep -q 'sh tests/formula-contract.sh' "$ci_workflow"
grep -q 'ruby -c Formula/lpm.rb' "$ci_workflow"
grep -q 'brew style Formula/lpm.rb' "$ci_workflow"

ruby -c "$formula" >/dev/null

render_root=$(mktemp -d)
trap 'rm -rf "$render_root"' EXIT HUP INT TERM
hash=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
VERSION=0.76.3 \
SHA_DARWIN_ARM64="$hash" \
SHA_DARWIN_X64="$hash" \
SHA_LINUX_ARM64="$hash" \
SHA_LINUX_X64="$hash" \
ruby "$renderer" \
  --output "$render_root/lpm.rb" \
  --release-base-url http://127.0.0.1:8765

ruby -c "$render_root/lpm.rb" >/dev/null
grep -Fq 'version "0.76.3"' "$render_root/lpm.rb"
grep -Fq 'url "http://127.0.0.1:8765/lpm-darwin-arm64.zip", using: :nounzip' "$render_root/lpm.rb"
grep -Fq 'assert_match "lpm #{version}"' "$render_root/lpm.rb"

if VERSION='0.76.3;false' \
  SHA_DARWIN_ARM64="$hash" \
  SHA_DARWIN_X64="$hash" \
  SHA_LINUX_ARM64="$hash" \
  SHA_LINUX_X64="$hash" \
  ruby "$renderer" --output "$render_root/invalid.rb" >/dev/null 2>&1; then
  echo "renderer accepted an invalid version" >&2
  exit 1
fi

if VERSION=0.76.3 \
  SHA_DARWIN_ARM64=not-a-sha \
  SHA_DARWIN_X64="$hash" \
  SHA_LINUX_ARM64="$hash" \
  SHA_LINUX_X64="$hash" \
  ruby "$renderer" --output "$render_root/invalid.rb" >/dev/null 2>&1; then
  echo "renderer accepted an invalid SHA-256" >&2
  exit 1
fi
