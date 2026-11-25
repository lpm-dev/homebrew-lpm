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
# Most Homebrew users have only the Command Line Tools, whose stapler fails on
# LPM's app, and some can't reach Apple. The formula checks LPM's Developer
# ID signature with codesign, which ships with macOS.
grep -q '"-R", CODE_REQUIREMENT, app_bundle' "$template"
grep -q '"-R", CODE_REQUIREMENT, installed_app' "$template"
grep -Fq '"-R", CODE_REQUIREMENT,' "$template"
grep -Fq 'libexec/"LPM CLI.app"' "$template"
grep -q 'leaf\[subject.OU\] = \\"823S8YKMRW\\"".freeze' "$template"
# Homebrew's install sandbox can't evaluate `notarized`; see the template.
if grep -q 'and notarized' "$template"; then
  echo "formula template requires notarized, which Homebrew's sandbox can't evaluate" >&2
  exit 1
fi
grep -q '"OPENSSL_CONF" => nil' "$template"
for file in "$template" "$formula"; do
  if grep -Eq '"/usr/bin/xcrun"|"stapler"|"/usr/bin/stapler"|"/usr/sbin/spctl"|syspolicy_check' "$file"; then
    echo "$file runs a developer tool or asks Apple's services during install" >&2
    exit 1
  fi
done
grep -q 'unexpected file inventory' "$template"
grep -q 'ruby scripts/render-formula.rb' "$workflow"
grep -q 'run-name: Update lpm.*correlation_id' "$workflow"
grep -q 'CORRELATION_ID:' "$workflow"
if grep -q 'cat > Formula/lpm.rb' "$workflow"; then
  echo "workflow still interpolates dispatch data into a shell heredoc" >&2
  exit 1
fi
# Dispatch data reaches scripts only through env, never the script text.
if grep -n 'client_payload' "$workflow" | grep -Ev '^[0-9]+:(run-name: |          [A-Z_0-9]+: \$\{\{ github\.event\.client_payload\.[a-z_0-9]+ \}\}$)'; then
  echo "workflow expands dispatch data outside run-name and env" >&2
  exit 1
fi
# The formula is rendered only from checksums the named release signed.
verify_line=$(grep -n 'run: bash scripts/verify-dispatched-release.sh' "$workflow" | cut -d: -f1)
render_line=$(grep -n 'ruby scripts/render-formula.rb' "$workflow" | cut -d: -f1)
if [ -z "$verify_line" ] || [ -z "$render_line" ] || [ "$verify_line" -ge "$render_line" ]; then
  echo "workflow must verify the dispatched release before rendering the formula" >&2
  exit 1
fi
grep -q 'bash tests/verify-dispatched-release.sh' "$ci_workflow"

grep -q 'pull_request:' "$ci_workflow"
grep -q 'sh tests/formula-contract.sh' "$ci_workflow"
grep -q 'ruby -c Formula/lpm.rb' "$ci_workflow"
grep -q 'brew style Formula/lpm.rb' "$ci_workflow"

ruby -c "$formula" >/dev/null

render_root=$(mktemp -d)
trap 'rm -rf "$render_root"' EXIT HUP INT TERM
rendered_formula="$render_root/Formula/lpm.rb"
mkdir -p "$(dirname "$rendered_formula")"
hash=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
VERSION=0.76.3 \
SHA_DARWIN_ARM64="$hash" \
SHA_DARWIN_X64=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \
SHA_LINUX_ARM64=cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc \
SHA_LINUX_X64=dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd \
ruby "$renderer" \
  --output "$rendered_formula" \
  --release-base-url http://127.0.0.1:8765

ruby -c "$rendered_formula" >/dev/null
brew style "$rendered_formula"
ruby "$repo_root/tests/formula-bundle-inventory.rb" "$formula" "$rendered_formula"
grep -Fq 'version "0.76.3"' "$rendered_formula"
grep -Fq 'url "http://127.0.0.1:8765/lpm-darwin-arm64.zip", using: :nounzip' "$rendered_formula"
grep -Fq 'assert_match "lpm #{version}"' "$rendered_formula"

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
