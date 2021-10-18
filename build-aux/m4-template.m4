# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_@MODULE@_FN_@FUNC@_PREPARE
# -------------------------------
m4_defun_once([_LTM_@MODULE@_FN_@FUNC@_PREPARE],
[
])# _LTM_@MODULE@_FN_@FUNC@_PREPARE


# LTM_@MODULE@_FN_@FUNC@(ARGS)
# ----------------------------
m4_defun_init([LTM_@MODULE@_FN_@FUNC@],
[],
[m4_require([_LTM_@MODULE@_FN_@FUNC@])
])# LTM_@MODULE@_FN_@FUNC@


# ---------------------------------------------------------------------------- #

# LTM_@MODULE@_INIT
# -----------------
m4_defun_once([LTM_@MODULE@_INIT],
[m4_require([_LTM_@MODULE@_FN_@FUNC@_PREPARE])
m4_pattern_forbid([^_LTM_@MODULE@_])
])# LTM_@MODULE@_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
