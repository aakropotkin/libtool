# -*- mode: autoconf; -*-
# ============================================================================ #
#
#
# ---------------------------------------------------------------------------- #

# _LTM_OPTS_FN_OPTIONS_PREP_PREPARE
# ---------------------------------
m4_defun_once([_LTM_OPTS_FN_OPTIONS_PREP_PREPARE],
[
# libtool_options_prep [ARG]...
# -----------------------------
# Preparation for options parsed by libtool.
libtool_options_prep ()
{
  $debug_mode

  # Option defaults:
  opt_config=false
  opt_dlopen=
  opt_dry_run=false
  opt_help=false
  opt_mode=
  opt_preserve_dup_deps=false
  opt_quiet=false

  nonopt=
  preserve_args=

  _G_rc_lt_options_prep=:

  # Shorthand for --mode=foo, only valid as the first argument
  case $[]1 in
  clean|clea|cle|cl)
    shift; set dummy --mode clean ${1+"$[]@"}; shift
    ;;
  compile|compil|compi|comp|com|co|c)
    shift; set dummy --mode compile ${1+"$[]@"}; shift
    ;;
  execute|execut|execu|exec|exe|ex|e)
    shift; set dummy --mode execute ${1+"$[]@"}; shift
    ;;
  finish|finis|fini|fin|fi|f)
    shift; set dummy --mode finish ${1+"$[]@"}; shift
    ;;
  install|instal|insta|inst|ins|in|i)
    shift; set dummy --mode install ${1+"$[]@"}; shift
    ;;
  link|lin|li|l)
    shift; set dummy --mode link ${1+"$[]@"}; shift
    ;;
  uninstall|uninstal|uninsta|uninst|unins|unin|uni|un|u)
    shift; set dummy --mode uninstall ${1+"$[]@"}; shift
    ;;
  *)
    _G_rc_lt_options_prep=false
    ;;
  esac

  if $_G_rc_lt_options_prep; then
    # Pass back the list of options.
    func_quote eval ${1+"$[]@"}
    libtool_options_prep_result=$func_quote_result
  fi
}
])# _LTM_OPTS_FN_OPTIONS_PREP_PREPARE


# LTM_OPTS_FN_OPTIONS_PREP([OPTS])
# --------------------------------
m4_defun_init([LTM_OPTS_FN_OPTIONS_PREP],
[libtool_options_prep $1],
[m4_require([_LTM_OPTS_FN_OPTIONS_PEREP_PREPARE])
libtool_options_prep $1
])# LTM_OPTS_FN_OPTIONS_PREP


# ---------------------------------------------------------------------------- #

# _LTM_OPTS_FN_PARSE_OPTIONS_PREPARE
# ----------------------------------
m4_defun_once([_LTM_OPTS_FN_PARSE_OPTIONS_PREPARE],
[
# libtool_parse_options [ARG]...
# ---------------------------------
# Provide handling for libtool specific options.
libtool_parse_options ()
{
  $debug_cmd

  _G_rc_lt_parse_options=false

  # Perform our own loop to consume as many options as possible in
  # each iteration.
  while test $[]# -gt 0; do
    _G_match_lt_parse_options=:
    _G_opt=$[]1
    shift
    case $_G_opt in
      --dry-run|--dryrun|-n)
                      opt_dry_run=:
                      ;;

      --config)       func_config ;;

      --dlopen|-dlopen)
                      opt_dlopen="${opt_dlopen+$opt_dlopen
}$[]1"
                      shift
                      ;;

      --preserve-dup-deps)
                      opt_preserve_dup_deps=: ;;

      --features)     func_features ;;

      --finish)       set dummy --mode finish ${1+"$[]@"}; shift ;;

      --help)         opt_help=: ;;

      --help-all)     opt_help=': help-all' ;;

      --mode)         test $[]# = 0 && func_missing_arg $_G_opt && break
                      opt_mode=$[]1
                      case $[]1 in
                        # Valid mode arguments:
                        clean|compile|execute|finish|install|link|relink|uninstall) ;;

                        # Catch anything else as an error
                        *) func_error "invalid argument for $_G_opt"
                           exit_cmd=exit
                           break
                           ;;
                      esac
                      shift
                      ;;

      --no-silent|--no-quiet)
                      opt_quiet=false
                      func_append preserve_args " $_G_opt"
                      ;;

      --no-warnings|--no-warning|--no-warn)
                      opt_warning=false
                      func_append preserve_args " $_G_opt"
                      ;;

      --no-verbose)
                      opt_verbose=false
                      func_append preserve_args " $_G_opt"
                      ;;

      --silent|--quiet)
                      opt_quiet=:
                      opt_verbose=false
                      func_append preserve_args " $_G_opt"
                      ;;

      --tag)          test $[]# = 0 && func_missing_arg $_G_opt && break
                      opt_tag=$[]1
                      func_append preserve_args " $_G_opt $[]1"
                      func_enable_tag "$[]1"
                      shift
                      ;;

      --verbose|-v)   opt_quiet=false
                      opt_verbose=:
                      func_append preserve_args " $_G_opt"
                      ;;

      # An option not handled by this hook function:
      *)              set dummy "$_G_opt" ${1+"$[]@"} ; shift
                      _G_match_lt_parse_options=false
                      break
                      ;;
    esac
    $_G_match_lt_parse_options && _G_rc_lt_parse_options=:
  done

  if $_G_rc_lt_parse_options; then
    # save modified positional parameters for caller
    func_quote eval ${1+"$[]@"}
    libtool_parse_options_result=$func_quote_result
  fi
}
])# _LTM_OPTS_FN_PARSE_OPTIONS_PREPARE


# LTM_OPTS_FN_PARSE_OPTIONS([OPTS])
# ---------------------------------
m4_defun_init([LTM_OPTS_FN_PARSE_OPTIONS],
[libtool_parse_options $1],
[m4_require([_LTM_OPTS_FN_PARSE_OPTIONS_PREPARE])
libtool_parse_options $1
])# LTM_OPTS_FN_PARSE_OPTIONS


# ---------------------------------------------------------------------------- #

# _LTM_OPTS_FN_VALIDATE_OPTIONS_PREPARE
# -------------------------------------
m4_defun_once([_LTM_OPTS_FN_VALIDATE_OPTIONS_PREPARE],
[m4_require([_LTM_VER_FN_CHECK_VERSION_MATCH_PREPARE])
# libtool_validate_options [ARG]...
# ---------------------------------
# Perform any sanity checks on option settings and/or unconsumed
# arguments.
libtool_validate_options ()
{
  # save first non-option argument
  if test 0 -lt $[]#; then
    nonopt=$[]1
    shift
  fi

  # preserve --debug
  test : = "$debug_cmd" || func_append preserve_args " --debug"

  case $host in
    # Solaris2 added to fix http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16452
    # see also: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59788
    *cygwin* | *mingw* | *pw32* | *cegcc* | *solaris2* | *os2*)
      # don't eliminate duplications in $postdeps and $predeps
      opt_duplicate_compiler_generated_deps=:
      ;;
    *)
      opt_duplicate_compiler_generated_deps=$opt_preserve_dup_deps
      ;;
  esac

  $opt_help || {
    # Sanity checks first:
    #func_check_version_match
    LTM_VER_FN_CHECK_VERSION_MATCH

    test yes != "$build_libtool_libs" \
      && test yes != "$build_old_libs" \
      && func_fatal_configuration "not configured to build any kind of library"

    # Darwin sucks
    eval std_shrext=\"$shrext_cmds\"

    # Only execute mode is allowed to have -dlopen flags.
    if test -n "$opt_dlopen" && test execute != "$opt_mode"; then
      func_error "unrecognized option '-dlopen'"
      $ECHO "$help" 1>&2
      exit $EXIT_FAILURE
    fi

    # Change the help message to a mode-specific one.
    generic_help=$help
    help="Try '$progname --help --mode=$opt_mode' for more information."
  }

  # Pass back the unparsed argument list
  func_quote eval ${1+"$[]@"}
  libtool_validate_options_result=$func_quote_result
}
])# _LTM_OPTS_FN_VALIDATE_OPTIONS_PREPARE


# LTM_OPTS_FN_VALIDATE_OPTIONS([ARGS])
# ------------------------------------
m4_defun_init([LTM_OPTS_FN_VALIDATE_OPTIONS],
[libtool_validate_options $1],
[m4_require([_LTM_OPTS_FN_VALIDATE_OPTIONS_PREPARE])
libtool_validate_options $1
])# LTM_OPTS_FN_VALIDATE_OPTIONS


# ---------------------------------------------------------------------------- #

# LTM_OPTS_INIT
# -------------
m4_defun_once([LTM_OPTS_INIT],
[
m4_require([_LTM_OPTS_FN_OPTIONS_PREP_PREPARE])
func_add_hook func_options_prep libtool_options_prep

m4_require([_LTM_OPTS_FN_PARSE_OPTIONS_PREPARE])
func_add_hook func_parse_options libtool_parse_options

m4_require([_LTM_OPTS_FN_VALIDATE_OPTIONS_PREPARE])
func_add_hook func_validate_options libtool_validate_options

m4_pattern_forbid([^_LTM_OPTS_])
])# LTM_OPTS_INIT


# ---------------------------------------------------------------------------- #

# LTM_PROCESS_OPTS
# ----------------
m4_defun_once([LTM_PROCESS_OPTS],
[m4_require([LTM_OPTS_INIT])
# Process options as early as possible so that --help and --version
# can return quickly.
func_options ${1+"$[]@"}
eval set dummy "$func_options_result"; shift
])# LTM_PROCESS_OPTS


# ---------------------------------------------------------------------------- #



# ============================================================================ #
# vim: set filetype=config :
