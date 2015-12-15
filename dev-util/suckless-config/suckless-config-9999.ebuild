EAPI=5
inherit savedconfig

DESCRIPTION="configuration for ghostavs suckless tools"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 x86-fbsd"
IUSE="savedconfig"

src_unpack() {
	mkdir "${S}"
	cat >"${S}/config.h" <<EOF
#ifndef SUCKLESS_CONFIG_H
#define SUCKLESS_CONFIG_H
/* modify the following macros */
#define COL_HFG "<+highlight foreground color+>"
#define COL_HBG "<+highlight background color+>"
#define CLO_FG  "<+default foreground color+>"
#define COL_BG  "<+default background color+>"
#define FONT    "<+font specification+>"
#endif /* SUCKLESS_CONFIG_H */
EOF
}

src_prepare() {
	restore_config config.h
}

src_install() {
	save_config config.h

	mkdir -p "${D}/usr/include"
	mv config.h "${D}/usr/include/suckless.h"
}
