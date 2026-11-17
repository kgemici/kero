#!/bin/sh
# Remove the app, its command, and its man page. Run as the user.
set -e
for target in /Applications/Kero.app /usr/local/bin/kero /usr/local/share/man/man1/kero.1; do
  [ -e "$target" ] || [ -L "$target" ] || continue
  if [ -w "$(dirname "$target")" ]; then s=""; else s=sudo; fi
  $s rm -rf "$target"
done
