# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit rpm

DESCRIPTION="Brother DCP-J152W CUPS wrapper"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://download.brother.com/welcome/dlf006981/dcpj152wcupswrapper-3.0.0-1.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="
	>=net-print/brother-DCP-J152W-lpr-3.0.0.1
	net-print/cups
"

src_unpack () {
	rpm_src_unpack ${A} || die "Cannot unpack"
	find ${WORKDIR}/${PN} -type f -exec sed -i 's|/lib\(32\|64\|\)/|/libexec/|g' {} +
}

src_install(){
	cp * -vr ${D}
}

pkg_postinst() {
	elog "Now run the wrapper located in:"
	elog "/usr/local/Brother/Printer/dcp195c/cupswrapper/cupswrapperdcp195c"
}
