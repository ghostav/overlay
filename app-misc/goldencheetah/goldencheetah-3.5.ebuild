# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

MY_PN="GoldenCheetah"

DESCRIPTION="Cycling performance software"
HOMEPAGE="http://www.goldencheetah.org/"
SRC_URI="https://github.com/GoldenCheetah/${MY_PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+webkit +usb -3d -R ical vlc"

DEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtserialport:5
	dev-qt/qtsvg:5
	dev-qt/qttranslations:5
	dev-qt/qtsql:5
	dev-qt/qtcharts:5
	webkit? (
		dev-qt/qtwebkit:5
	)
	!webkit? (
		dev-qt/qtwebengine:5
		dev-qt/qtpositioning:5
	)
	3d? ( x11-libs/qwtplot3d )
	R? ( dev-lang/R )
	dev-qt/qtbluetooth:5
	usb? ( dev-libs/libusb-compat )
	ical? ( dev-libs/libical )
	vlc? ( media-video/vlc )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	eapply_user

	#eapply "${FILESDIR}"/${P}-flex-fix.patch
	#eapply "${FILESDIR}"/${P}-make_pair-fix.patch

	(	echo 'CONFIG += release'
		use webkit || echo 'DEFINES += NOWEBKIT'
		use R && echo 'DEFINES += GC_WANRT_R'
		#use SRMIO && echo 'SRMIO_INSTALL = /usr/local/srmio'
		#use D2XX && echo 'D2XX = /usr/include/d2xx'
		#use twitter && echo 'KQOAUTH_INSTALL = /usr/local/kqoauth'
		use 3d && echo 'QWT3D_INSTALL = /usr/local/qwtplot3d'
		#use earth && echo 'KML_INSTALL = /usr'
		use ical && echo 'ICAL_INSTALL = /usr/local/libical'
		use usb && echo 'LIBUSB_INSTALL = /usr'
		use vlc && echo 'VLC_INSTALL = /usr/bin/vlc'
	) >src/gcconfig.pri

	sed -e "s:#QMAKE_LRELEASE:QMAKE_LRELEASE:" \
		-e "s:GC_VIDEO_NONE:GC_VIDEO_QT5:" \
		-e "s:#LIBUSB_INSTALL.*$:LIBUSB_INSTALL = /usr:" \
		-e "s:#CONFIG += release:CONFIG += release:" \
		src/gcconfig.pri.in > src/gcconfig.pri || die
	use webkit || echo "DEFINES += NOWEBKIT" >> src/gcconfig.pri
	sed -e "s:/usr/local/:/usr/:" qwt/qwtconfig.pri.in > qwt/qwtconfig.pri || die
	sed -e "s:#QMAKE_CXXFLAGS:QMAKE_CXXFLAGS:" -i qwt/qwtbuild.pri || die
}

src_configure() {
	eqmake5 -recursive
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install

	dobin "src/GoldenCheetah"
}
