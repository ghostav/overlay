# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games git-r3 cmake-utils

DESCRIPTION="Remake of the Caesar III strategy game"
HOMEPAGE="https://bitbucket.org/dalerank/caesaria"
EGIT_REPO_URI="https://bitbucket.org/dalerank/caesaria.git"
KEYWORDS=""
IUSE="-debug"

LICENSE="GPL-3"
SLOT="0"

DEPEND="media-libs/libsdl
	media-libs/libpng
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-fonts/freefont
	"
RDEPEND="${DEPEND}"

MY_DATADIR="${GAMES_DATADIR}"/${PN}

src_unpack() {
	git-r3_checkout
	mkdir ${P}_build
	pushd ${P}_build >/dev/null
		python2 ../$P/dep/localeconv/loadtable.py || die
	popd >/dev/null
}

src_configure() {
	# default to `right' resource directory
	sed -i 's|vfs::Path( argv\[0\] )\.directory()|vfs::Path( "'"${MY_DATADIR}"'" )|' source/main.cpp || die

	sed -i 's|execute_process(.*loadtable.py)||g' source/CMakeLists.txt

	# disable updater
	sed -i "s/add_subdirectory(updater updater)//g" CMakeLists.txt || die

	# disable tileseteditor
	sed -i "s/add_subdirectory(tileset tileset)//g" CMakeLists.txt || die

	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE_RELEASE=`usex debug 0 1`
	)
	cmake-utils_src_configure
}

src_install() {
	newgamesbin $S/bin/caesaria.linux ${PN}
	dodir "${MY_DATADIR}"
	mv $S/bin/resources "${ED}/${MY_DATADIR}/"
	keepdir "${MY_DATADIR}/resources/"
	prepgamesdirs
}

pkg_postinst() {
	elog "This ebuild only installs the executable _without_ artwork and"
	elog "other required files for this game. See their homepage"
	elog "${HOMEPAGE}"
	elog "for more information and for instructions how to obtain those"
	elog "files from the official Caesar CD. Then put them into:"
	elog "${MY_DATADIR}/resources/"
}
