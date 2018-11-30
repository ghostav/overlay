# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: brother-lpr.eclass
# @MAINTAINER:
# Jonas Rabenstein
# @AUTHOR:
# Jonas Rabenstein
# @BLURB: lpr driver for brother devices
# @DESCRIPTION:
inherit rpm
LICENSE="Brother"
SLOT="0"
DEPEND=""
RDEPEND="app-text/a2ps"
DESCRIPTION="Brother ${BROTHER_PRINTER} LPR print drivers"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/${BROTHER_PRINTER}lpr-${PV%.*}-${PV##*.}.i386.rpm"

brother-lpr_src_unpack () {
	rpm_src_unpack $A
}

brother-lpr_src_install () {
	cp * -vr ${D}
}

EXPORT_FUNCTIONS src_unpack src_install
