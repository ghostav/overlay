# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
inherit git-r3 eutils udev distutils-r1

DESCRIPTION="Extracts FIT files from ANT-FS based sport watches such as Garmin Forerunner 60, 405CX, 310XT, 610 and 910XT."
HOMEPAGE="https://github.com/Tigge/${PN}"
EGIT_REPO_URI="https://github.com/Tigge/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/openant-0.3
"
DEPEND="
	${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
