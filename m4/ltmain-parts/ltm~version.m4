# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE
# ---------------------------------------
m4_defun_once([_LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE],
[
# func_check_version_match
# ------------------------
# Ensure that we are using m4 macros, and libtool script from the same
# release of libtool.
func_check_version_match ()
{
  if test "$package_revision" != "$macro_revision"; then
    if test "$VERSION" != "$macro_version"; then
      if test -z "$macro_version"; then
        cat >&2 <<_LT_EOF
$progname: Version mismatch error.  This is $PACKAGE $VERSION, but the
$progname: definition of this LT_INIT comes from an older release.
$progname: You should recreate aclocal.m4 with macros from $PACKAGE $VERSION
$progname: and run autoconf again.
_LT_EOF
      else
        cat >&2 <<_LT_EOF
$progname: Version mismatch error.  This is $PACKAGE $VERSION, but the
$progname: definition of this LT_INIT comes from $PACKAGE $macro_version.
$progname: You should recreate aclocal.m4 with macros from $PACKAGE $VERSION
$progname: and run autoconf again.
_LT_EOF
      fi
    else
      cat >&2 <<_LT_EOF
$progname: Version mismatch error.  This is $PACKAGE $VERSION, revision $package_revision,
$progname: but the definition of this LT_INIT comes from revision $macro_revision.
$progname: You should recreate aclocal.m4 with macros from revision $package_revision
$progname: of $PACKAGE $VERSION and run autoconf again.
_LT_EOF
    fi

    exit $EXIT_MISMATCH
  fi
}
])# _LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE


# LTM_VER_FN_CHECK_VERSION_MATCH
# ------------------------------
m4_defun_init([LTM_VER_FN_CHECK_VERSION_MATCH],
[func_check_version_match],
[m4_require([_LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE])
func_check_version_match
])# LTM_VER_FN_CHECK_VERSION_MATCH


# ---------------------------------------------------------------------------- #

# LTM_VER_INIT
# ------------
m4_defun_once([LTM_VER_INIT],
[m4_require([_LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE])
m4_pattern_forbid([^_LTM_VER_])
])# LTM_VER_INIT



# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
