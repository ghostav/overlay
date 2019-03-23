# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A memory allocator that automatically reduces the memory footprint of C/C++ applications."
HOMEPAGE="https://github.com/plasma-umass/mesh"
EGIT_REPO_URI="https://github.com/plasma-umass/mesh"
EGIT_SUBMODULES=( '*' )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	./configure
}

src_compile() {
	emake lib LDFLAGS="${LDFLAGS} -Wl,-soname,libmesh.so"
}

src_install() {
	dolib.so libmesh.so
	doheader -r src/plasma
}
