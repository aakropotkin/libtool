# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_TAGS_FN_ENABLE_TAG_PREPARE
# -------------------------------
m4_defun_once([_LTM_TAGS_FN_ENABLE_TAG_PREPARE],
[
# func_enable_tag TAGNAME
# -----------------------
# Verify that TAGNAME is valid, and either flag an error and exit, or
# enable the TAGNAME tag.  We also add TAGNAME to the global $taglist
# variable here.
func_enable_tag ()
{
  # Global variable:
  tagname=$[]1

  re_begincf="^# ### BEGIN LIBTOOL TAG CONFIG: $tagname\$"
  re_endcf="^# ### END LIBTOOL TAG CONFIG: $tagname\$"
  sed_extractcf=/$re_begincf/,/$re_endcf/p

  # Validate tagname.
  case $tagname in
    *[[!-_A-Za-z0-9,/]]*)
      func_fatal_error "invalid tag name: $tagname"
      ;;
  esac

  # Don't test for the "default" C tag, as we know it's
  # there but not specially marked.
  case $tagname in
    CC) ;;
    *)
      if $GREP "$re_begincf" "$progpath" >/dev/null 2>&1; then
        taglist="$taglist $tagname"

        # Evaluate the configuration.  Be careful to quote the path
        # and the sed script, to avoid splitting on whitespace, but
        # also don't use non-portable quotes within backquotes within
        # quotes we have to do it in 2 steps:
        extractedcf=`$SED -n -e "$sed_extractcf" < "$progpath"`
        eval "$extractedcf"
      else
        func_error "ignoring unknown tag $tagname"
      fi
      ;;
  esac
}
])# _LTM_TAGS_FN_ENABLE_TAG_PREPARE


# LTM_TAGS_FN_ENABLE_TAG(TAGNAME)
# -------------------------------
m4_defun_init([LTM_TAGS_FN_ENABLE_TAG],
[func_enable_tag $1],
[{
  m4_require([_LTM_TAGS_FN_ENABLE_TAG_PREPARE])
  func_enable_tag $1
}
])# LTM_TAGS_FN_ENABLE_TAG(TAGNAME)


# ---------------------------------------------------------------------------- #

# LTM_TAGS_INIT
# -----------
m4_defun_once([LTM_TAGS_INIT],
[m4_require([_LTM_TAGS_FN_ENABLE_TAG_PREPARE])
m4_pattern_forbid([^_LTM_TAGS_])
])# LTM_TAGS_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
