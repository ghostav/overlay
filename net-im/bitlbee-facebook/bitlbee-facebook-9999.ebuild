# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surf/surf-9999.ebuild,v 1.3 2014/09/16 19:23:43 jer Exp $

EAPI=5
inherit eutils git-r3 toolchain-funcs

DESCRIPTION="The Facebook protocol plugin for bitlbee"
HOMEPAGE="https://github.com/jgeboski/bitlbee-facebook.git"
EGIT_REPO_URI="https://github.com/jgeboski/bitlbee-facebook.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND=">=net-im/bitlbee-3.4[plugins] >=dev-libs/json-glib-0.14.0"
RDEPEND="net-im/bitlbee"

pkg_pretend() {
	# check wether /usr/include/bitlbee exists
	[[ -d /usr/include/bitlbee ]] || eerror "could not find bitlbee header files in /usr/include/bitlbee"
}

src_prepare() {
	./autogen.sh
}

src_compile() {
	emake
}

#src_install() {
# we can use the default here (;
#}

pkg_postinst() {
	elog "Getting started:"
	elog ""
	elog "> account add facebook <username> <password>"
	elog "> account <acc> on"
	elog ""
	elog "Group Chats (existing chat):"
	elog "> fbchats [acc]"
	elog "> fbjoin [acc] <index> <channel>"
	elog "> /topic <message>"
	elog "> /invite <user>"
	elog ""
	elog "Group Chats (creating chat):"
	elog "> fbcreate [acc] <user,user,...>"
	elog "> fbjoin [acc] 1 <channel>"
	elog "> /topic <message>"
	elog "> /invite <user>"
}
