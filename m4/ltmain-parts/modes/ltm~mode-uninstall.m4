# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_MODE_UNINSTALL_FN_@FUNC@
# -----------------------
m4_defun([_LTM_MODE_UNINSTALL_FN_@FUNC@],
[
])# _LTM_MODE_UNINSTALL_FN_@FUNC@


# ---------------------------------------------------------------------------- #

# LTM_MODE_UNINSTALL_INIT
# -----------
m4_defun_once([LTM_MODE_UNINSTALL_INIT],
[m4_require([_LTM_MODE_UNINSTALL_FN_@FUNC@])
m4_pattern_forbid([^_LTM_MODE_UNINSTALL_])
])# LTM_MODE_UNINSTALL_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
