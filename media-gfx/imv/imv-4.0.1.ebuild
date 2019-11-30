# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="Minimal image viewer designed for tiling window manager users"
HOMEPAGE="https://github.com/eXeC64/imv"
SRC_URI="https://github.com/eXeC64/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="png jpeg gif raw psd webp mng openexr svg tiff test wayland X"
REQUIRED_USE="
	|| ( png jpeg gif svg tiff )
	|| ( wayland X )
"

RDEPEND="
	!sys-apps/renameutils
	media-libs/fontconfig
	media-libs/libsdl2[wayland?,X?]
	media-libs/sdl2-ttf[X?]
	psd? ( media-libs/freeimage[psd] )
	raw? ( media-libs/freeimage[raw] )
	webp? ( media-libs/freeimage[webp] )
	openexr? ( media-libs/freeimage[openexr] )
	png? ( || (
		media-libs/libpng
		media-libs/freeimage[png]
	) )
	jpeg? ( || (
		media-libs/libjpeg-turbo
		media-libs/freeimage[jpeg]
	) )
	gif? ( media-libs/libnsgif )
	svg? ( gnome-base/librsvg )
	tiff? ( || (
		media-libs/tiff
		media-libs/freeimage[tiff]
	) )
"

DEPEND="${RDEPEND}
	test? ( dev-util/cmocka )"

src_configure() {
	local windows=all
	local freeimage=no
	local libtiff=no
	local libpng=no
	local libjpeg=no
	local librsvg=no
	local libnsgif=no

	if use wayland && use X; then
		windows=all
	elif use wayland ; then
		windows=wayland
	elif use X ; then
		windows=X
	else
		eerror "At least one of X/wayland required"
	fi

	set -x
	if use png ; then
		has_version 'media-libs/libpng' && libpng=yes || freeimage=yes
	fi
	if use jpeg ; then
		has_version 'media-libs/libjpeg-turbo' && libjpeg=yes || freeimage=yes
	fi
	use gif && libnsgif=yes
	use svg && librsvg=yes
	if use tiff ; then
		has_version 'media-libs/tiff' && libtiff=yes || freeimage=yes
	fi
	(use psd || use raw || use webp || use openexr) && freeimage=yes

	echo >>config.mk "WINDOWS=${windows}"
	printf >>config.mk 'BACKEND_%s=%s\n' \
		FREEIMAGE	${freeimage} \
		LIBTIFF	${libtiff} \
		LIBPNG	${libpng} \
		LIBJPEG	${libjpeg} \
		LIBRSVG	${librsvg} \
		LIBNSGIF	${libnsgif}
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
