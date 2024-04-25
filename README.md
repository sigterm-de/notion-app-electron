# Package Details: notion-app-electron
based on [https://aur.archlinux.org/packages/notion-app-electron](https://aur.archlinux.org/packages/notion-app-electron), adapted to run on Ubuntu `Noble Numbat` 24.04

I am utilising the [makedeb](https://www.makedeb.org/) project to convert ArchLinux PKGBUILD to a Ubuntu native package.

Please note:
- you need a working electron installation (I prefer via `nvm` + `npx`)
- there is no `xdg-open` support, you have to log on to Notion via magic email link
- the software comes as-is and no support nor responsibility is to be expected of me ;-)
  See the ArchLinux User repository intro for this as well! - https://aur.archlinux.org/
  > AUR packages are user produced content. Any use of the provided files is at your own risk.
- one should be able to use different flavours of `makedeb` as well - https://docs.makedeb.org/installing/docker/

## pre-requisites
The final application is called via `exec npx electron /usr/lib/notion-app $NOTION_USER_FLAGS "$@"` (see `notion-app`), thus you need to have `npx` installed. 

## build
- `docker run -it -v ${PWD}:/tmp/notion ghcr.io/makedeb/makedeb-beta:ubuntu-latest`
  - `cd /tmp/notion`
  - `makedeb -s`
- the build process should result in a Debian package, written to the mounted volume
- leave the container

## install + run
- `sudo dpkg -i notion-app-electron_3.5.0-1_amd64.deb`
- run the application once in a terminal (`npx electron /usr/lib/notion-app`) to eventually install electron or see other error messages
- There might be an error re:chrome-sandbox not owned by root
  fix it by
    `sudo chown root:root /home/daniel/.npm/_npx/1323dbbc85759269/node_modules/electron/dist/chrome-sandbox`
    `sudo chmod 4755 /home/daniel/.npm/_npx/1323dbbc85759269/node_modules/electron/dist/chrome-sandbox`

---

## Licence
I couldn't find an entrypoint for AUR, so I chose MIT for this fork.