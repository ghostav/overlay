EAPI=5
inherit eutils git-r3 toolchain-funcs

DESCRIPTION="simple background setter based on imlib2"
HOMEPAGE="https://github.com/Gottox/bgs"
EGIT_REPO_URI="https://github.com/Gottox/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

RDEPEND="
    x11-libs/libX11
    media-libs/imlib2
    x11-libs/libXinerama
"
DEPDEND="${RDEPEND}"

src_prepare() {
  # add the correct settings to config.mk
  sed -e "s|^\(\s*PREFIX =\).*|\1 /usr|" -i config.mk
  epatch_user
}

src_compile() {
  emake
}

src_install() {
  emake DESTDIR="${D}" install
}
