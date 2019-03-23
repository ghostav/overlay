[[ "${CATEGORY}" != 'dev-libs' ]] || [[ "${PN}" != 'mesh' ]] || return 0

[[ "${EBUILD_PHASE}" == configure ]] || return 0

use mesh || return 0

if [[ "$LDFLAGS" == *"-lmesh"* ]] ; then
	einfo "mesh allocator already in linkflags"
else
	einfo "add mesh allocator linker flags"
	LDFLAGS="${LDFLAGS} -lmesh"
fi
