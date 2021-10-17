# mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_ECHO
# ---------------
m4_define([_LTM_IO_FN_ECHO],
[
# func_echo ARG...
# ----------------
# Libtool also displays the current mode in messages, so override
# funclib.sh func_echo with this custom definition.
func_echo ()
{
  $debug_cmd

  _G_message=$*

  func_echo_IFS=$IFS
  IFS=$nl
  for _G_line in $_G_message; do
    IFS=$func_echo_IFS
    $ECHO "$progname${opt_mode+: $opt_mode}: $_G_line"
  done
  IFS=$func_echo_IFS
}
])# _LTM_IO_FN_ECHO


# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_WARNING
# ------------------
m4_define([_LTM_IO_FN_WARNING],
[
# func_warning ARG...
# -------------------
# Libtool warnings are not categorized, so override funclib.sh
# func_warning with this simpler definition.
func_warning ()
{
  $debug_cmd

  $warning_func ${1+"$@"}
}
])# _LTM_IO_FN_WARNING


# ---------------------------------------------------------------------------- #

# _LTM_IO_USAGE_PREPARE
# ---------------------
m4_define([_LTM_IO_USAGE_PREPARE],
[
## ---------------- ##
## Options parsing. ##
## ---------------- ##

# Hook in the functions to make sure our own options are parsed during
# the option parsing loop.

usage='$progpath [[OPTION]]... [[MODE-ARG]]...'

# Short help message in response to '-h'.
usage_message="Options:
       --config             show all configuration variables
       --debug              enable verbose shell tracing
   -n, --dry-run            display commands without modifying any files
       --features           display basic configuration information and exit
       --mode=MODE          use operation mode MODE
       --no-warnings        equivalent to '-Wnone'
       --preserve-dup-deps  don't remove duplicate dependency libraries
       --quiet, --silent    don't print informational messages
       --tag=TAG            use configuration variables from tag TAG
   -v, --verbose            print more informational messages than default
       --version            print version information
   -W, --warnings=CATEGORY  report the warnings falling in CATEGORY [[all]]
   -h, --help, --help-all   print short, long, or detailed help message
"
])# _LTM_IO_USAGE_PREPARE


# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_HELP
# ---------------
m4_define([_LTM_IO_FN_HELP],
[
# Additional text appended to 'usage_message' in response to '--help'.
func_help ()
{
  $debug_cmd

  func_usage_message
  $ECHO "$long_help_message

MODE must be one of the following:

       clean           remove files from the build directory
       compile         compile a source file into a libtool object
       execute         automatically set library path, then run a program
       finish          complete the installation of libtool libraries
       install         install libraries or executables
       link            create a library or an executable
       uninstall       remove libraries from an installed directory

MODE-ARGS vary depending on the MODE.  When passed as first option,
'--mode=MODE' may be abbreviated as 'MODE' or a unique abbreviation of that.
Try '$progname --help --mode=MODE' for a more detailed description of MODE.

When reporting a bug, please describe a test case to reproduce it and
include the following information:

       host-triplet:   $host
       shell:          $SHELL
       compiler:       $LTCC
       compiler flags: $LTCFLAGS
       linker:         $LD (gnu? $with_gnu_ld)
       version:        $progname (GNU @PACKAGE@) @VERSION@
       automake:       `($AUTOMAKE --version) 2>/dev/null |$SED 1q`
       autoconf:       `($AUTOCONF --version) 2>/dev/null |$SED 1q`

Report bugs to <@PACKAGE_BUGREPORT@>.
GNU @PACKAGE@ home page: <@PACKAGE_URL@>.
General help using GNU software: <http://www.gnu.org/gethelp/>."
  exit 0
}
])# _LTM_IO_FN_HELP


# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_FATAL_CONFIG
# -----------------------
m4_define([_LTM_IO_FN_FATAL_CONFIG],
[
# func_fatal_configuration ARG...
# -------------------------------
# Echo program name prefixed message to standard error, followed by
# a configuration failure hint, and exit.
func_fatal_configuration ()
{
  func_fatal_error ${1+"$@"} \
    "See the $PACKAGE documentation for more information." \
    "Fatal configuration error."
}
])# _LTM_IO_FN_FATAL_CONFIG


# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_CONFIG
# -----------------
m4_define([_LTM_IO_FN_CONFIG],
[
# func_config
# -----------
# Display the configuration for all the tags in this script.
func_config ()
{
  re_begincf='^# ### BEGIN LIBTOOL'
  re_endcf='^# ### END LIBTOOL'

  # Default configuration.
  $SED "1,/$re_begincf CONFIG/d;/$re_endcf CONFIG/,\$d" < "$progpath"

  # Now print the configurations for the tags.
  for tagname in $taglist; do
    $SED -n "/$re_begincf TAG CONFIG: $tagname\$/,/$re_endcf TAG CONFIG: $tagname\$/p" < "$progpath"
  done

  exit $?
}
])# _LTM_IO_FN_CONFIG


# ---------------------------------------------------------------------------- #

# _LTM_IO_FN_FEATURES
m4_define([_LTM_IO_FN_FEATURES],
[
# func_features
# -------------
# Display the features supported by this script.
func_features ()
{
  echo "host: $host"
  if test yes = "$build_libtool_libs"; then
    echo "enable shared libraries"
  else
    echo "disable shared libraries"
  fi
  if test yes = "$build_old_libs"; then
    echo "enable static libraries"
  else
    echo "disable static libraries"
  fi

  exit $?
}
])# _LTM_IO_FN_FEATURES


# ---------------------------------------------------------------------------- #

# LTM_IO_INIT
# -----------
m4_define([LTM_IO_INIT],
[_LTM_IO_FN_ECHO
_LTM_IO_FN_WARNING
_LTM_IO_USAGE_PREPARE
_LTM_IO_FN_HELP
_LTM_IO_FN_FATAL_CONFIG
_LTM_IO_FN_CONFIG
_LTM_IO_FN_FEATURES
])# LTM_IO_INIT


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
