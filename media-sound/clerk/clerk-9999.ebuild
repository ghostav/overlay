# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 eutils

DESCRIPTION="mpd client based on rofi"
HOMEPAGE="https://github.com/carnager/clerk"
EGIT_REPO_URI="https://github.com/carnager/clerk.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="" #-lastfm -mpd-sima"

RDEPEND="
	x11-misc/rofi
	>=media-sound/mpc-0.26
	dev-python/python-mpd
	sys-apps/util-linux
	dev-lang/perl
"

src_compile() { true; }

src_install() {
	emake DESTDIR=${D} PREFIX=/usr
}
