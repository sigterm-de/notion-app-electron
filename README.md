# Package Details: notion-app-electron
based on [https://aur.archlinux.org/packages/notion-app-electron](https://aur.archlinux.org/packages/notion-app-electron), adapted to run on Ubuntu `Noble Numbat` 24.04

## pre-requisites
The final application is called via `exec npx electron /usr/lib/notion-app $NOTION_USER_FLAGS "$@"` (see `notion-app`), thus you need to have `npx` installed. 

## build
- `docker run -it -v ${PWD}:/tmp/notion ghcr.io/makedeb/makedeb-beta:ubuntu-latest`
  - `cd /tmp/notion`
  - `makedeb -s`

## install + run
- `sudo dpkg -i notion-app-electron_3.4.2-1_amd64.deb`
- run the application once in a terminal (`npx electron /usr/lib/notion-app`) to eventually install electron or see other error messages
- There might be an error re:chrome sandbox not owned by root
  fix it by
    `sudo chown root:root /home/daniel/.npm/_npx/1323dbbc85759269/node_modules/electron/dist/chrome-sandbox`
    `sudo chmod 4755 /home/daniel/.npm/_npx/1323dbbc85759269/node_modules/electron/dist/chrome-sandbox`
