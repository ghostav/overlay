# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A set of C++ language extensions to facilitate aspect-oriented programming with C/C++"
HOMEPAGE="http://www.aspectc.org"
SRC_URI="bootstrap-aspectc++? ( http://aspectc.org/releases/${PV}/ac-${PV}.tar.gz )
	!bootstrap-aspectc++? ( http://aspectc.org/releases/${PV}/ac-bin-linux-x86-64bit-2.1.tar.gz )"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="+bootstrap-aspectc++ +clang -puma debug static"
REQUIRED_USE="^^ ( puma clang )"
command -v ac++ >/dev/null || REQUIRED_USE+=" bootstrap-aspectc++"
RESTRICT="mirror"

COMMON_DEPEND="
	sys-devel/gcc[cxx]
	dev-libs/libxml2
	clang? ( >=sys-devel/llvm-3.4[clang] )
"
DEPEND="${COMMON_DEPEND}
	!bootstrap-aspectc++? ( puma? ( sys-devel/aspect++ ) )
"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${PN}"

my_target() {
	usex debug linux-debug linux-release
}

MY_AC="ac++"
MY_AG="ag++"
src_configure() {
	if use bootstrap-aspectc++ ; then
		MY_AC="${S}/ac++"
		MY_AG="${S}/ag++"
	fi
}

src_compile() {
	local frontend
	local puma_extra=""

	if use puma;  then
		frontend=Puma
		puma_extra=compile
	else
		frontend=Clang
		puma_extra=MINI=1
	fi
	CPPFLAGS+=" -DNDEBUG"
	export CPPFLAGS

	emake -C Puma $puma_extra ROOT="${S}/Puma" AC=$MY_AC AGXX=$MY_AG TARGET="`my_target`"
	emake -C AspectC++ SHARED=`usex static '' 1` FRONTEND=$frontend TARGET="`my_target`"
 	emake -C Ag++ TARGET="`my_target`"
}

src_install() {
	local release="AspectC++/bin/`my_target`"
	dobin ${release}/ac++
	dobin ${release}/ag++
}
