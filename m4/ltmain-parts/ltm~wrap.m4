# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_EXECUTABLE_P_PREPARE
# ---------------------------------
m4_defun_once([_LTM_WRAP_FN_EXECUTABLE_P_PREPARE],
[
# func_ltwrapper_executable_p file
# True iff FILE is a libtool wrapper executable
# This function is only a basic sanity check; it will hardly flush out
# determined imposters.
func_ltwrapper_executable_p ()
{
  func_ltwrapper_exec_suffix=
  case $[]1 in
    *.exe) ;;
    *) func_ltwrapper_exec_suffix=.exe ;;
  esac
  $GREP "$magic_exe" "$[]1$func_ltwrapper_exec_suffix" >/dev/null 2>&1
}
])# _LTM_WRAP_FN_EXECUTABLE_P_PREPARE


# LTM_WRAP_FN_EXECUTABLE_P(FILE)
# ------------------------------
m4_defun_init([LTM_WRAP_FN_EXECUTABLE_P],
[func_ltwrapper_executable_p $1],
[m4_require([_LTM_WRAP_FN_EXECUTABLE_P_PREPARE])
func_ltwrapper_executable_p $1
])# LTM_WRAP_FN_EXECUTABLE_P


# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_SCRIPT_P_PREPARE
# -----------------------------
m4_defun_once([_LTM_WRAP_FN_SCRIPT_P_PREPARE],
[m4_require([_LTM_FS_FN_GENERATED_BY_LT_P_PREPARE])
# func_ltwrapper_script_p file
# True iff FILE is a libtool wrapper script
# This function is only a basic sanity check; it will hardly flush out
# determined imposters.
func_ltwrapper_script_p ()
{
  test -f "$[]1" &&  \
    $lt_truncate_bin < "$[]1" 2>/dev/null | func_generated_by_libtool_p
}
])# _LTM_WRAP_FN_SCRIPT_P_PREPARE


# LTM_WRAP_FN_SCRIPT_P(FILE)
# --------------------------
m4_defun_init([LTM_WRAP_FN_SCRIPT_P],
[func_ltwrapper_script_p $1],
[m4_require([_LTM_WRAP_FN_SCRIPT_P_PREPARE])
func_ltwrapper_script_p $1
])# LTM_WRAP_FN_SCRIPT_P


# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_SCRIPTNAME_PREPARE
# -------------------------------
m4_defun_once([_LTM_WRAP_FN_SCRIPTNAME_PREPARE],
[
# func_ltwrapper_scriptname file
# Assumes file is an ltwrapper_executable
# uses $file to determine the appropriate filename for a
# temporary ltwrapper_script.
func_ltwrapper_scriptname ()
{
  func_dirname_and_basename "$[]1" "" "."
  func_stripname '' '.exe' "$func_basename_result"
  func_ltwrapper_scriptname_result=$func_dirname_result/$objdir/${func_stripname_result}_ltshwrapper
}
])# _LTM_WRAP_FN_SCRIPTNAME_PREPARE


# LTM_WRAP_FN_SCRIPTNAME(FILE)
# ----------------------------
m4_defun_init([LTM_WRAP_FN_SCRIPTNAME],
[func_ltwrapper_scriptname $1],
[m4_require([_LTM_WRAP_FN_SCRIPTNAME_PREPARE])
func_ltwrapper_scriptname $1
])# LTM_WRAP_FN_SCRIPTNAME


# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_WRAPPER_P_PREPARE
# ------------------------------
m4_defun_once([_LTM_WRAP_FN_WRAPPER_P_PREPARE],
[m4_require([_LTM_WRAP_FN_EXECUTABLE_P_PREPARE])
# func_ltwrapper_p file
# True iff FILE is a libtool wrapper script or wrapper executable
# This function is only a basic sanity check; it will hardly flush out
# determined imposters.
func_ltwrapper_p ()
{
  func_ltwrapper_script_p "$[]1" || func_ltwrapper_executable_p "$[]1"
}
])# _LTM_WRAP_FN_WRAPPER_P_PREPARE


# LTM_WRAP_FN_WRAPPER_P(FILE)
# ---------------------------
m4_defun_init([LTM_WRAP_FN_WRAPPER_P],
[func_ltwrapper_p $1],
[m4_require([_LTM_WRAP_FN_WRAPPER_P_PREPARE])
func_ltwrapper_p $1
])# LTM_WRAP_FN_WRAPPER_P


# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_EXECUTE_CMDS_PREPARE
# ---------------------------------
m4_defun_once([_LTM_WRAP_FN_EXECUTE_CMDS_PREPARE],
[
# func_execute_cmds commands fail_cmd
# Execute tilde-delimited COMMANDS.
# If FAIL_CMD is given, eval that upon failure.
# FAIL_CMD may read-access the current command in variable CMD!
func_execute_cmds ()
{
  $debug_cmd

  save_ifs=$IFS; IFS='~'
  for cmd in $[]1; do
    IFS=$sp$nl
    eval cmd=\"$cmd\"
    IFS=$save_ifs
    func_show_eval "$cmd" "${2-:}"
  done
  IFS=$save_ifs
}
])# _LTM_WRAP_FN_EXECUTE_CMDS_PREPARE


# LTM_WRAP_FN_EXECUTE_CMDS(CMDS, FAIL-CMD)
# ----------------------------------------
m4_defun_init([LTM_WRAP_FN_EXECUTE_CMDS],
[func_execute_cmds $1 $2],
[m4_require([_LTM_WRAP_FN_EXECUTE_CMDS_PREPARE])
func_execute_cmds $1 $2
])# LTM_WRAP_FN_EXECUTE_CMDS


# ---------------------------------------------------------------------------- #

# _LTM_WRAP_FN_SOURCE_PREPARE
# -----------------------------
m4_defun_once([_LTM_WRAP_FN_SOURCE_PREPARE],
[
# func_source file
# Source FILE, adding directory component if necessary.
# Note that it is not necessary on cygwin/mingw to append a dot to
# FILE even if both FILE and FILE.exe exist: automatic-append-.exe
# behavior happens only for exec(3), not for open(2)!  Also, sourcing
# 'FILE.' does not work on cygwin managed mounts.
func_source ()
{
  $debug_cmd

  case $[]1 in
  */* | *\\*) . "$[]1" ;;
  *)          . "./$[]1" ;;
  esac
}
])# _LTM_WRAP_FN_SOURCE_PREPARE


# LTM_WRAP_FN_SOURCE(FILE)
# ------------------------
m4_defun_init([LTM_WRAP_FN_SOURCE],
[func_source $1],
[m4_require([_LTM_WRAP_FN_SOURCE_PREPARE])
func_source $1
])# LTM_WRAP_FN_SOURCE


# ---------------------------------------------------------------------------- #

# LTM_WRAP_INIT
# -------------
m4_defun_once([LTM_WRAP_INIT],
[m4_require([_LTM_WRAP_FN_EXECUTABLE_P_PREPARE])
m4_require([_LTM_WRAP_FN_SCRIPT_P_PREPARE])
m4_require([_LTM_WRAP_FN_SCRIPTNAME_PREPARE])
m4_require([_LTM_WRAP_FN_WRAPPER_P_PREPARE])
m4_require([_LTM_WRAP_FN_EXECUTE_CMDS_PREPARE])
m4_require([_LTM_WRAP_FN_SOURCE_PREPARE])
m4_pattern_forbid([^_LTM_WRAP_])
])# LTM_WRAP_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
