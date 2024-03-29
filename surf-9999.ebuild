# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-9999.ebuild,v 1.2 2013/10/04 14:52:10 jer Exp $

EAPI=5
inherit eutils git-2 savedconfig toolchain-funcs

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"
EGIT_REPO_URI="git://github.com/raymontag/surf.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="
	dev-libs/glib
	net-libs/libsoup
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libX11
"
DEPEND="
	${COMMON_DEPEND}
	virtual/pkgconfig
"
RDEPEND="
	!sci-chemistry/surf
	${COMMON_DEPEND}
	x11-apps/xprop
	x11-misc/dmenu
"

pkg_setup() {
	if ! use savedconfig; then
		elog "The default config.h assumes you have"
		elog " net-misc/curl"
		elog " x11-terms/st"
		elog "installed to support the download function."
		elog "Without those, downloads will fail (gracefully)."
		elog "You can fix this by:"
		elog "1) Installing these packages, or"
		elog "2) Setting USE=savedconfig and changing config.h accordingly."
	fi
}

src_prepare() {
	restore_config config.h
	epatch ${P}-gentoo.patch
	epatch surf-0.6-searchengines.diff
	epatch surf-0.6-bookmarks.diff
	epatch_user
	tc-export CC PKG_CONFIG
}

src_install() {
	default
	save_config config.h
}
