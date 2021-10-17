# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_FS_FN_FUNC_LO2O
# --------------------
m4_defun([_LTM_FS_FN_FUNC_LO2O],
[
# func_lo2o OBJECT-NAME
# ---------------------
# Transform OBJECT-NAME from a '.lo' suffix to the platform specific
# object suffix.
lo2o=s/\\.lo\$/.$objext/
o2lo=s/\\.$objext\$/.lo/

if test yes = "$_G_HAVE_XSI_OPS"; then
  eval 'func_lo2o ()
  {
    case $1 in
      *.lo) func_lo2o_result=${1%.lo}.$objext ;;
      *   ) func_lo2o_result=$1               ;;
    esac
  }'
else
  # ...otherwise fall back to using sed.
  func_lo2o ()
  {
    func_lo2o_result=`$ECHO "$1" | $SED "$lo2o"`
  }
fi
])# _LTM_FS_FN_FUNC_LO2O


# ---------------------------------------------------------------------------- #

# _LTM_FS_FN_FUNC_XFORM
# ---------------------
m4_defun([_LTM_FS_FN_FUNC_XFORM],
[
if test yes = "$_G_HAVE_XSI_OPS"; then
  # func_xform LIBOBJ-OR-SOURCE
  # ---------------------------
  # Transform LIBOBJ-OR-SOURCE from a '.o' or '.c' (or otherwise)
  # suffix to a '.lo' libtool-object suffix.
  eval 'func_xform ()
  {
    func_xform_result=${1%.*}.lo
  }'
else
  func_xform ()
  {
    func_xform_result=`$ECHO "$1" | $SED 's|\.[[^.]]*$|.lo|'`
  }
fi
])# _LTM_FS_FN_FUNC_XFORM


# ---------------------------------------------------------------------------- #

# LTM_FS_INIT
# -----------
m4_defun_once([LTM_FS_INIT],
[m4_require([_LTM_FS_FN_FUNC_LO2O])
m4_require([_LTM_FS_FN_FUNC_XFORM])
m4_pattern_forbid([^_LTM_FS_])
])# LTM_FS_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
