# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="vim plugin: vim-spell"
KEYWORDS="amd64"
SLOT="0"
IUSE=""

for l10n in cs da de el en es fr he hu it nl pl pt ru ; do
	RDEPEND="${RDEPEND} l10n_${l10n}? ( app-vim/vim-spell-${l10n} )"
	IUSE="${IUSE} l10n_${l10n}"
done
