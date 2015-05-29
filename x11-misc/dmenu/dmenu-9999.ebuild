# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dmenu/dmenu-9999.ebuild,v 1.2 2014/06/30 13:53:58 jer Exp $

EAPI=5
inherit eutils git-r3 toolchain-funcs

URI="192.168.178.10"
DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
EGIT_REPO_URI="git+ssh://git@${URI}/suckless/${PN}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="xinerama"

RDEPEND="
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
	virtual/sl-config
"
DEPEND="${RDEPEND}
	xinerama? ( virtual/pkgconfig )
"

src_prepare() {
	cp "/etc/suckless/config.h" "../"
	# Respect our flags
	sed -i \
		-e '/^CFLAGS/{s|=.*|+= -ansi -pedantic -Wall $(INCS) $(CPPFLAGS)|}' \
		-e '/^LDFLAGS/s|= -s|+=|' \
		config.mk || die
	# Make make verbose
	sed -i \
		-e 's|^	@|	|g' \
		-e '/^	echo/d' \
		Makefile || die

	epatch_user
}

src_configure() {
	tc-export PKG_CONFIG
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		"XINERAMAFLAGS=$(
			usex xinerama "-DXINERAMA $(
				${PKG_CONFIG} --cflags xinerama 2>/dev/null
			)" ''
		)" \
		"XINERAMALIBS=$(
			usex xinerama "$(
				${PKG_CONFIG} --libs xinerama 2>/dev/null
			)" ''
		)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
