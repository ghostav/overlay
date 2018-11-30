# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit git-r3

DESCRIPTION="a small daemon to act on remote or local events"
HOMEPAGE="https://j4status.j4tools.org/"
#SRC_URI="${GITHUB}/archive/${PNV}.tar.xz"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sardemff7/j4status.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=("*")

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+i3bar +networkmanager +upower +sensors +pulseaudio -mpd -systemd -static"

DEPEND="
	>=sys-devel/autoconf-2.65
	>=sys-devel/automake-1.11
	|| ( >=dev-util/pkgconfig-0.25 >=dev-util/pkgconf-0.2 )
	>=dev-lang/vala-0.12
	>=x11-libs/libnotify-0.5.0
	networkmanager? ( net-misc/networkmanager )
	upower? ( || ( sys-power/upower sys-power/upower-pm-utils ) )
	sensors? ( sys-apps/lm_sensors )
	pulseaudio? ( media-sound/pulseaudio )
	mpd? ( media-libs/libmpdclient )
"
RDEPEND="${DEPEND}"

src_configure() {
	./autogen.sh	
	econf \
		$(use_enable i3bar	i3bar-input-output)	\
		$(use_enable networkmanager	nm-input)	\
		$(use_enable upower	upower-input)	\
		$(use_enable sensors	sensors-input)	\
		$(use_enable pulseaudio	pulseaudio-input)	\
		$(use_enable mpd	mpd-input)	\
		$(use_enable systemd systemd-input)	\
		$(use_enable static)
}
