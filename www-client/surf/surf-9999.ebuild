# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-9999.ebuild,v 1.3 2014/09/16 19:23:43 jer Exp $

EAPI=5
inherit eutils git-r3 toolchain-funcs

DESCRIPTION="a simple web browser based on WebKit/GTK+"
HOMEPAGE="http://surf.suckless.org/"
EGIT_REPO_URI="https://git.ghostav.ddnss.de/code/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

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
	dev-util/suckless-config
	${COMMON_DEPEND}
	x11-apps/xprop
	x11-misc/dmenu
	net-misc/curl
	x11-terms/st
"

src_prepare() {
	find . -type f -exec sed -i 's|"../config.h"|<suckless.h>|g' {} +
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch_user
	tc-export CC PKG_CONFIG
}
