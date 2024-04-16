# Maintainer: Asuka Minato <i at asukaminato dot eu dot org>
# Maintainer: Kid <hi at xuann dot wang>
# Contributor: Jaime Martínez Rincón <jaime@jamezrin.name>

pkgname=notion-app-electron
pkgver=3.4.2
pkgrel=1
pkgdesc='Your connected workspace for wiki, docs & projects'
arch=(amd64)
url=https://www.notion.so/desktop
license=(custom)
depends=(
    bash
	libgcc-s1
	libc6
	hicolor-icon-theme
	# electron - must be already installed on host, we can not check via packages
)
makedepends=(
	p7zip-full
	# asar - must be installed via npm, we can not check via packages // `npm install --global @electron/asar`
	icoutils
	npm
)
install=.install

source=(
	"https://desktop-release.notion-static.com/Notion%20Setup%20${pkgver}.exe"
	https://github.com/WiseLibs/better-sqlite3/releases/download/v9.4.5/better-sqlite3-v9.4.5-electron-v121-linux-x64.tar.gz
	notion-app
	notion.desktop
)
sha256sums=('7ae722f4c8718c700375e9786aaa864c989c3fd907491c9bd4dbdeb4a59372b6'
            '49fd940252e77b9c8cfabd1297cedeedd0a33b7749055eb819cc7d5c3c010703'
            '2211eeea02d6e79a273c7fcf818fb6f09397505635aa26f2bfda0e85fa581725'
            '19a5f973f1e9291081aa05512e07c61447e8c30e1a43dd22d0cc1090837d1e19')

prepare() {
     sudo npm install --global @electron/asar
	# bsdtar can't recognize 3.2.1, so use 7z
	7za x ./*.exe
	rm ./*.exe
	asar e "$srcdir"/**/app.asar "$srcdir/unpacked"
	icotool -x -w 256 "$srcdir/unpacked/icon.ico" -o "$srcdir/notion.png"
	icotool -x -w 256 "$srcdir/resources/trayIcon.ico" -o "$srcdir/trayIcon.png"

	sed -i -e 's/"win32"===process.platform/(true)/g
		    s/_.Store.getState().app.preferences?.isAutoUpdaterDisabled/(true)/g
		    s!extra-resources!/usr/share/notion-app!g
		    s/trayIcon.ico/trayIcon.png/g' "$srcdir/unpacked/.webpack/main/index.js"
	find $srcdir \( -name "clang-format.js" -or -name "conversion.js" -or -name "eslint-format.js" \) -delete -printf "rm %p to make namcap happy.\n"
}

package() {
	local usr="$pkgdir/usr"
	local share="$usr/share"
	local lib="$usr/lib/notion-app"

	install -d "$lib"
	cp -a "$srcdir/unpacked/"{package.json,node_modules,.webpack} "$lib"
	install -Dm644 "$srcdir/build/Release/better_sqlite3.node" -t "$lib/node_modules/better-sqlite3/build/Release/"
	install -Dm755 notion-app -t "$usr/bin"
	install -Dm644 "$srcdir/notion.desktop" -t "$share/applications"
	install -Dm644 "$srcdir/notion.png" -t "$share/icons/hicolor/256x256/apps"
	install -Dm644 "$srcdir/trayIcon.png" -t "$share/notion-app"
	find "$pkgdir" -type d -empty -delete
}
