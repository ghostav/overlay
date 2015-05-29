EAPI=5
inherit eutils git-r3

URI="192.168.178.10"

DESCRIPTION="(virtual) configuration repository for ghostavs suckless tools"
HOMEPAGE="http://${URI}/cgit/suckless/"
EGIT_REPO_URI="git+ssh://git@${URI}/suckless"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 x86-fbsd"

src_prepare() {
	epatch_user
}

src_install() {
	mkdir "${D}/etc"
	rm -rf "${S}/.git"
	mv "${S}" "${D}/etc/suckless"
}
