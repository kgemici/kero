#!/usr/bin/env bash
# Local macOS build: ad-hoc signed, not notarized (the Developer ID in
# mygo.json is the upstream maintainer's).
# Usage: scripts/local-build.sh [--install]
#   --install  install the existing build if there is one, else build first.
set -euo pipefail
cd "$(dirname "$0")/.."

out=build/darwin-arm64

# --install alone reuses an existing build; a plain run always rebuilds.
if [[ "${1:-}" == "--install" ]] && [[ -d "$out/Kero.app" ]]; then
  echo "Reusing existing build in $out (run without --install to rebuild)"
else
  go tool mygo build -platform darwin/arm64 -sign - -skip-notarize -skip-dmg
fi

if [[ "${1:-}" == "--install" ]]; then
  # --force: kerod is the app's binary, so it counts as Kero running.
  fish -c "install-mac-bundle --force $out/Kero.app"
  # Man page: /usr/local/share/man/man1, with sudo only where it is not writable.
  mandir=/usr/local/share/man/man1
  d="$mandir"; while [[ ! -d "$d" ]]; do d="$(dirname "$d")"; done
  if [[ -w "$d" ]]; then s=""; else s=sudo; fi
  $s install -d "$mandir" && $s install -m 644 "man/man1/kero.1" "$mandir/"
fi
