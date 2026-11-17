# Kero

- Cutting a release: follow [RELEASING.md](RELEASING.md).


## Local installation (2026-11-17)

Local install interface: `scripts/local-build.sh` builds; `scripts/local-build.sh --install` reuses an existing app and installs it plus kero.1; `scripts/uninstall.sh` removes the app, command and page. Installation uses the owner’s install-mac-bundle signer.

## Fork workflow

`origin` is the fork (`kgemici/kero`), `upstream` is `egoist/kero`. `main` is local-only: `upstream/main` plus the local install commits (`scripts/local-build.sh`, `scripts/uninstall.sh`, `man/man1/kero.1` and the section above). None of that goes upstream.

- Update with `git fetch upstream && git rebase upstream/main`, then `git push --force-with-lease origin main`.
- Work meant for upstream is cut from upstream, never from `main`: `git switch -c <branch> upstream/main`.
- Never push `main` to `upstream`. In a fresh clone, run `git remote set-url --push upstream DISABLED`.
