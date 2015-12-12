# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="MPD Web GUI - written in C, utilizing Websockets and Bootstrap/JS"
HOMEPAGE="http://www.ympd.org"
SRC_URI="https://github.com/notandy/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static openssl"

DEPEND="net-libs/libwebsockets[openssl?]"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with static STATIC_WEBSOCKETS)
	)
	cmake-utils_src_configure
}
