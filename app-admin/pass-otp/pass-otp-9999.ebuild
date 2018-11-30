# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A pass extension for managing one-time-password (OTP) tokens"
HOMEPAGE="https://github.com/tadfisher/pass-otp"
SRC_URI=""
EGIT_REPO_URI="$HOMEPAGE"


LICENSE="GPL3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qrencode"

DEPEND=""
RDEPEND="
	>=app-admin/pass-1.7
	sys-auth/oath-toolkit
	qrencode? ( media-gfx/grencode )
"
