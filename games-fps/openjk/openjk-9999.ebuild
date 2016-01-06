# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games git-r3 eutils cmake-utils

DESCRIPTION="Community effort to maintain and improve Jedi Academy + Jedi Outcast released by Raven Software "
HOMEPAGE="https://openjk.org"
EGIT_REPO_URI="https://github.com/JACoders/OpenJK.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+system-sdl2 +system-jpeg +system-openal +system-png +system-jpeg +system-zlib +outcast +academy server +client"

RDEPEND="
	virtual/opengl
	system-sdl2? ( >=media-libs/libsdl2-2.0.3 )
	system-openal? ( media-libs/openal )
	system-png? ( media-libs/libpng )
	system-jpeg? ( || (
		media-libs/libjpeg-turbo
		media-libs/jpeg
		media-libs/openjpeg
	) )
	system-zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
"

src_configure() {
	CFLAGS="${CFLAGS} -std=c99"
	local mycmakeargs=(
		$(cmake-utils_useno system-jpeg UseInternalJPEG)
		$(cmake-utils_useno system-openal UseInternalOpenAL)
		$(cmake-utils_useno system-png UseInternalPNG)
		$(cmake-utils_useno system-sdl2 UseInternalSDL2)
		$(cmake-utils_useno system-zlib UseInternalZlib)
		$(cmake-utils_use outcast BuildJK2SPEngine)
		$(cmake-utils_use outcast BuildJK2SPGame)
		$(cmake-utils_use outcast BuildJK2SPRdVanilla)
		$(cmake-utils_use academy BuildSPEngine)
		$(cmake-utils_use academy BuildSPGame)
		$(cmake-utils_use academy BuildSPRdVanilla)
		$(cmake-utils_use server  BuildMPDed)
		$(cmake-utils_use server  BuildMPGame)
		$(cmake-utils_use client  BuildMPCGame)
		$(cmake-utils_use client  BuildMPEngine)
		$(cmake-utils_use client  BuildMPRdVanilla)
		$(cmake-utils_use client  BuildMPUI)
		#$(cmake-utils_use test    BuildTests)
		-DCMAKE_INSTALL_PREFIX=${GAMES_DATADIR}
		-DProjectName="OpenJK-$(git describe --always --long)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# TODO: x86_64 with real arch
	use outcast && \
		games_make_wrapper openjo ${GAMES_DATADIR}/JediOutcast/openjo_sp.x86_64 ${GAMES_DATADIR}/JediOutcast ${GAMES_DATADIR}/JediOutcast
	use academy && \
		games_make_wrapper openja ${GAMES_DATADIR}/JediAcademy/openjk_sp.x86_64 ${GAMES_DATADIR}/JediAcademy ${GAMES_DATADIR}/JediAcademy
	use client && \
		games_make_wrapper openja_client ${GAMES_DATADIR}/JediAcademy/openjk.x86_64 ${GAMES_DATADIR}/JediAcademy ${GAMES_DATADIR}/JediAcademy
	use server && \
		games_make_wrapper openja_server ${GAMES_DATADIR}/JediAcademy/openjkded.x86_64 ${GAMES_DATADIR}/JediAcademy ${GAMES_DATADIR}/JediAcademy

	prepgamesdirs
}


