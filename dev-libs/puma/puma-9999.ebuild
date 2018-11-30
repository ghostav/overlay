# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Source code analysis and transformation for C/C++ and more"
HOMEPAGE="https://puma.aspectc.org"
SRC_URI="bootstrap? ( http://www.aspectc.org:8080/job/Build_Puma/Platform=linux_x86/lastSuccessfulBuild/artifact/puma-source-woven.tar.bz2 )
	!bootstrap? ( http://www.aspectc.org:8080/job/Build_Puma/Platform=linux_x86/lastSuccessfulBuild/artifact/puma-source.tar.bz2 )"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+bootstrap +mini -mini_only"

DEPEND=""
RDEPEND="${DEPEND}"
