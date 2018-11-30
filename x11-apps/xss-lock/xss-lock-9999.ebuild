# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="use external locker as X screen saver"
HOMEPAGE="https://bitbucket.org/raymonad/xss-lock"
EGIT_REPO_URI="https://bitbucket.org/raymonad/xss-lock.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion zsh-completion +tools"

DEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	find $D/usr/share/doc/xss-lock/ -type f -printf '%p\n' \
	| while read file ; do
		case $file in
		*.sh.bz2|*.sh|*.patch|*.patch.bz2)
			if ! use tools ; then
				rm $D/usr/share/doc/xss-lock/$file
				continue
			fi
			;;
		*)	;;
		esac
		mv $D/usr/share/doc/xss-lock/$file $file
		dodoc $file
		rm $file
	done
	use bash-completion || rm -r $D/usr/share/bash-completion
	use zsh-completion  || rm -r $D/usr/share/zsh
	find $D -type d -empty -exec rmdir -p {} +
}
