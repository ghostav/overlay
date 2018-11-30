# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit rpm

DESCRIPTION="Brother DCP-J152W LPR print drivers"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://download.brother.com/welcome/dlf006979/dcpj152wlpr-3.0.0-1.i386.rpm"

LICENSE="Brother"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="net-print/cups"
RDEPEND="${DEPEND}
	app-text/a2ps"

src_unpack () {
	   rpm_src_unpack ${A}
}

src_install(){
	cp * -vr ${D}
}

