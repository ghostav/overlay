# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: brother-cupswrapper.eclass
# @MAINTAINER:
# Jonas Rabenstein
# @AUTHOR:
# Jonas Rabenstein
# @BLURB: cupswrapper driver for brother devices
# @DESCRIPTION:
inherit rpm
LICENSE="GPL"
SLOT="0"
DEPEND=""
RDEPEND=">=$CATEGORY/${P/cupswrapper/lpr}"
DESCRIPTION="Brother ${BROTHER_PRINTER} CUPS wrapper"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/${BROTHER_PRINTER}cupswrapper-${PV%.*}-${PV##*.}.i386.rpm"

brother-cupswrapper_src_unpack () {
	rpm_src_unpack ${A} || die "Cannot unpack"
}

brother-cupswrapper_src_install () {
	dodir /usr/share/ppd/cupsfilters
	find . -type f -name '*.ppd' -exec mv -t "${D}/usr/share/ppd/cupsfilters/" {} +
}

EXPORT_FUNCTIONS src_unpack src_install
