# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit gnome2 git-r3 autotools

DESCRIPTION="NetworkManager VPN integration for iodine"
HOMEPAGE="https://honk.sigxcpu.org/piki/projects/network-manager-iodine/"
SRC_URI=""
EGIT_REPO_URI="git://git.gnome.org/network-manager-iodine"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-pic +gtk +authdlg +libnm nls -static-libs +shared-libs -absolute-paths"

RDEPEND="
	>=net-misc/networkmanager-0.9.2
	>=net-vpn/iodine-0.6.0_rc1
	gtk? ( >=gnome-extra/nm-applet-1.1.0 )
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
"
GNOME2_EAUTORECONF="yes"

src_prepare () {
	gnome2_src_prepare
}

src_configure() {
	PKG_CONFIG=`which pkg-config` gnome2_src_configure	\
		--disable-dependency-tracking \
		--disable-more-warnings	\
		$(use_enable absolute-paths)		\
		$(use_enable static-libs static)	\
		$(use_enable shared-libs shared)	\
		$(use_enable nls)					\
		$(use_with pic)						\
		$(use_with gtk gnome)				\
		$(use_with authdlg)					\
		$(use_with libnm libnm-glib)
}
