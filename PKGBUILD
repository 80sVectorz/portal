pkgname=portal
pkgver=1.0
pkgrel=1
pkgdesc="A tool that lets you navigate directories quickly and in style. "
arch=(any)
url="https://github.com/krijnlol/portal"
license=('unknown')
depends=('python')
options=()
source=("portal.sh"
        "portalCONFIG.py"
        "portalDB.py")
sha256sums=(SKIP SKIP SKIP)

package() {
	install -Dm755 "portal.sh" "${pkgdir}/usr/bin/portal"
	
	_pydir="${pkgdir}/usr/bin/portal_bin"
	install -Dm755 "portalCONFIG.py" "${_pydir}/portalCONFIG.py"
	install -Dm755 "portalDB.py" "${_pydir}/portalDB.py"
}
