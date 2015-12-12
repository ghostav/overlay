# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
inherit git-r3 eutils udev distutils-r1

DESCRIPTION="A python library to download and upload files from ANT-FS compliant devices (Garmin products)"
HOMEPAGE="https://github.com/Tigge/openant"
EGIT_REPO_URI="https://github.com/Tigge/openant.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

RDEPEND="
	${PYTHON_DEPS}
	udev? ( virtual/udev )
	>=dev-lang/python-2.7
	>=dev-python/pyusb-1.0.0_beta2
"
DEPEND="
	${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_prepare_all () {
	use udev && sed -i 's|MODE="0666"|MODE="0660", OWNER="root", GROUP="ant"|' resources/ant-usb-sticks.rules
	sed -i 's/install_udev_rules(\(True\|False\))/pass/g' setup.py
	distutils-r1_python_prepare_all
}

python_install_all() {
	distuilts-r1_python_install_all
	use udev && udev_newrules resources/ant-usb-sticks.rules 80-ant-usb-sticks.rules
}

pkg_preinst () {
	use udev && enewgroup ant
}

pkg_postinst () {
	if use udev ; then
		einfo "add users to the 'ant' group in order to allow them access th usb"
		einfo "sticks without root privilegs"
		udev_reload
		einfo "if you already inserted your stick, you have to call 'udevadm trigger'"
		einfo "in order to have it recognized"
	fi
}
