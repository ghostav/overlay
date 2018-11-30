# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils git-2

DESCRIPTION="Userspace implementation of a wire protocol similar to the ANT/ANT+/ANT-FS protocols"
HOMEPAGE="https://github.com/ralovich/antpm/"
EGIT_REPO_URI="https://github.com/ralovich/antpm/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost[threads]
	dev-libs/libusb:1
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="$S/src"

src_prepare() {
	sed -i -e 's:set(Boost_USE_STATIC_LIBS        ON):set(Boost_USE_STATIC_LIBS	OFF):' \
		src/CMakeLists.txt

	base_src_prepare
}
