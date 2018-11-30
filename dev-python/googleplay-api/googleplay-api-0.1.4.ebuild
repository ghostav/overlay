# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(
	python2_7
	python3_4 python3_5 python3_6
	pypy
)

inherit distutils-r1

DESCRIPTION="Google Play Unofficial Python API"
HOMEPAGE="https://github.com/NoMore201/googleplay-api"
SRC_URI="https://github.com/NoMore201/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-python/pycrypto
	dev-python/protobuf-python
	dev-python/clint
	dev-python/requests
"
RDEPEND="${DEPEND}"
