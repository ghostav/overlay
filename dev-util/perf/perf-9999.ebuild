# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit versionator eutils toolchain-funcs python-single-r1 linux-info

DESCRIPTION="Userland tools for Linux Performance Counters"
HOMEPAGE="https://perf.wiki.kernel.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="audit debug +demangle +doc gtk numa perl python slang unwind"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="audit? ( sys-process/audit )
	demangle? ( sys-devel/binutils:= )
	gtk? ( x11-libs/gtk+:2 )
	numa? ( sys-process/numactl )
	perl? ( dev-lang/perl )
	slang? ( dev-libs/newt )
	unwind? ( sys-libs/libunwind )
	dev-libs/elfutils"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	doc? (
		app-text/asciidoc
		app-text/sgml-common
		app-text/xmlto
		sys-process/time
	)
	python? ( ${PYTHON_DEPS} )"

S_K="${S}"
S="${S_K}/tools/perf"

CONFIG_CHECK="~PERF_EVENTS ~KALLSYMS"

pkg_setup() {
	linux-info_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_unpack() {
	get_version
	set_arch_to_kernel
	local paths=(
		tools/arch tools/build tools/include tools/lib tools/perf tools/scripts
		include lib arch/$ARCH/lib
	)
	set_arch_to_portage

	# We expect the tar implementation to support the -j option (both
	# GNU tar and libarchive's tar support that).
	echo ">>> Copy source from ${KV_DIR}"
	mkdir -p "${S_K}"
	local expression
	while read expression; do
		local p
		for p in $expression; do
			mkdir -p "${S_K}/$p"
			rmdir "${S_K}/$p"
			cp -r "${KV_DIR}/$p" "${S_K}/$p"
		done
	done <"${KV_DIR}/tools/perf/MANIFEST"
}

src_prepare() {
	# Drop some upstream too-developer-oriented flags and fix the
	# Makefile in general
	sed -i \
		-e 's:-Werror::' \
		-e 's:-ggdb3::' \
		-e 's:-fstack-protector-all::' \
		-e 's:^LDFLAGS =:EXTLIBS +=:' \
		-e '/\(PERL\|PYTHON\)_EMBED_LDOPTS/s:ALL_LDFLAGS +=:EXTLIBS +=:' \
		-e '/-x c - /s:\$(ALL_LDFLAGS):\0 $(EXTLIBS):' \
		"${S}"/config/Makefile #|| die
	sed -i \
		-e 's:$(sysconfdir_SQ)/bash_completion.d:/usr/share/bash-completion:' \
		"${S}"/Makefile.perf #|| die
	sed -i -e 's:-Werror::' "${S_K}"/tools/lib/api/Makefile #|| die

	# Avoid the call to make kernelversion
	echo "#define PERF_VERSION \"${KV_FULL%${KV_EXTRA}${KV_LOCAL}}\"" > PERF-VERSION-FILE

	# The code likes to compile local assembly files which lack ELF markings.
	find -name '*.S' -exec sed -i '$a.section .note.GNU-stack,"",%progbits' {} +
}

puse() { usex $1 "" no; }
perf_make() {
	# The arch parsing is a bit funky.  The perf tools package is integrated
	# into the kernel, so it wants an ARCH that looks like the kernel arch,
	# but it also wants to know about the split value -- i386/x86_64 vs just
	# x86.  We can get that by telling the func to use an older linux version.
	# It's kind of a hack, but not that bad ...
	local arch=$(tc-arch-kernel)
	emake V=1 \
		CC="$(tc-getCC)" AR="$(tc-getAR)" LD="$(tc-getLD)" \
		prefix="/usr" bindir_relative="bin" \
		EXTRA_CFLAGS="${CFLAGS}" \
		ARCH="${arch}" \
		NO_DEMANGLE=$(puse demangle) \
		NO_GTK2=$(puse gtk) \
		NO_LIBAUDIT=$(puse audit) \
		NO_LIBPERL=$(puse perl) \
		NO_LIBPYTHON=$(puse python) \
		NO_LIBUNWIND=$(puse unwind) \
		NO_NEWT=$(puse slang) \
		NO_LIBNUMA=$(puse numa) \
		WERROR=0 \
		"$@"
}

src_compile() {
	perf_make -f Makefile.perf
	use doc && perf_make -C Documentation
}

src_test() {
	:
}

src_install() {
	perf_make -f Makefile.perf install DESTDIR="${D}"

	dodoc CREDITS

	dodoc *txt Documentation/*.txt
	if use doc ; then
		dohtml Documentation/*.html
		doman Documentation/*.1
	fi
}

pkg_postinst() {
	if ! use doc ; then
		elog "Without the doc USE flag you won't get any documentation nor man pages."
		elog "And without man pages, you won't get any --help output for perf and its"
		elog "sub-tools."
	fi
}
