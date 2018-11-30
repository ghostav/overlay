# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: brother.eclass
# @MAINTAINER:
# Jonas Rabenstein
# @AUTHOR:
# Jonas Rabenstein
# @BLURB: brother print driver
# @DESCRIPTION:
LICENSE="Brother GPL-2"
RDEPEND="app-text/a2ps"
DESCRIPTION="Brother ${BROTHER_PRINTER} print drivers"
HOMEPAGE="http://support.brother.com/g/b/productlist.aspx?c=us&lang=en&q=${BROTHER_PRINTER}"
SRC_URI="
	http://www.brother.com/pub/bsc/linux/dlf/${BROTHER_PRINTER}cupswrapper-${PV%.*}-${PV##*.}.i386.rpm -> cupswrapper.rpm
	http://www.brother.com/pub/bsc/linux/dlf/${BROTHER_PRINTER}lpr-${PV%.*}-${PV##*.}.i386.rpm -> lpr.rpm"

inherit rpm

brother-lpr_src_unpack () {
	rpm_src_unpack
	mkdir ${P}
}

brother-lpr_src_install () {
	dodir /usr/share/ppd/cupsfilters
	find ../*cupswrapper* -name '*.ppd' -exec mv -t "${D}/usr/share/ppd/cupsfilters/" {} +
}

EXPORT_FUNCTIONS src_unpack src_install
	

