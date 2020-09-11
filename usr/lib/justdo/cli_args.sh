#!/bin/bash
# shellcheck disable=SC1090,SC2154,SC2034


# ARGBASH_SET_INDENT([  ])
# ARG_OPTIONAL_SINGLE([duration],[d],[Pomodoro time in mins],[25 ])
# ARG_OPTIONAL_SINGLE([color],[c],[Color of bar or None],[Blue ])
# ARG_OPTIONAL_SINGLE([rev-color],[r],[Color of revision bar or None],[Green ])
# ARG_OPTIONAL_SINGLE([width],[w],[Width of bar],[40 ])
# ARG_OPTIONAL_BOOLEAN([notify],[],[Notify with message],[on])
# ARG_OPTIONAL_BOOLEAN([sound],[],[Notify with sound],[on])
# ARG_OPTIONAL_BOOLEAN([show],[],[Show time remaining],[on])
# ARG_OPTIONAL_BOOLEAN([show-percentage],[],[Show percentage of time remaining],[off])

# ARG_VERSION_AUTO(["${VERSION}"])
# ARG_HELP([A simple pomodoro timer for the shell.],[No more deep shits, just use the pomodoro timer.])

# ARG_POSITIONAL_SINGLE([task_name],[Pomodoro task name],[Pomodoro])
# ARG_POSITIONAL_DOUBLEDASH([])

# ARG_USE_ENV([NOTIFIER],[],[The executable used to show notifications])
# ARG_USE_ENV([NOTIFY_TITLE],[],[The notification header])
# ARG_USE_ENV([SPLAYER],[],[The executable used to play sounds])
# ARG_USE_ENV([SND_DONE],[],[The done sound file])
# ARG_USE_ENV([NO_COLOR],[],[Disable color output (use any value)])

# ARG_TYPE_GROUP([nnint],[mins],[duration])
# ARG_TYPE_GROUP([nnint],[secs],[ticks])
# ARG_TYPE_GROUP([nnint],[chars],[width])
# ARG_TYPE_GROUP_SET([color],[color],[color,rev-color],[Red,Green,Yellow,Blue,None])

# ARGBASH_PREPARE()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info

# Setting environmental variables
# Setting environmental variables
# Setting environmental variables
# Setting environmental variables
# Setting environmental variables


# # When called, the process ends.
# Args:
#   $1: The exit message (print to stderr)
#   $2: The exit code (default is 1)
# if env var _PRINT_HELP is set to 'yes', the usage is print to stderr (prior to $1)
# Example:
#   test -f "$_arg_infile" || _PRINT_HELP=yes die "Can't continue, have to supply file as an argument, got '$_arg_infile'" 4
die()
{
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}

# validators

nnint()
{
	printf "%s" "$1" | grep -q '^\s*+\?[0-9]\+\s*$' || die "The value of argument '$2' is '$1', which is not a non-negative integer."
	printf "%d" "$1"
}


color()
{
  local _allowed=("Red" "Green" "Yellow" "Blue" "None") _seeking="$1"
  for element in "${_allowed[@]}"
  do
    test "$element" = "$_seeking" && echo "$element" && return 0
  done
  die "Value '$_seeking' (of argument '$2') doesn't match the list of allowed values: 'Red', 'Green', 'Yellow', 'Blue' and 'None'" 4
}


# Function that evaluates whether a value passed to it begins by a character
# that is a short option of an argument the script knows about.
# This is required in order to support getopts-like short options grouping.
begins_with_short_option()
{
  local first_option all_short_options='dcrwvh'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
# The positional args array has to be reset before the parsing, because it may already be defined
# - for example if this script is sourced by an argbash-powered script.
_positionals=()
_arg_task_name="Pomodoro"
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_duration="25 "
_arg_color="Blue "
_arg_rev_color="Green "
_arg_width="40 "
_arg_notify="on"
_arg_sound="on"
_arg_show="on"
_arg_show_percentage="off"


# Function that prints general usage of the script.
# This is useful if users asks for it, or if there is an argument parsing error (unexpected / spurious arguments)
# and it makes sense to remind the user how the script is supposed to be called.
print_help()
{
  printf '%s\n' "A simple pomodoro timer for the shell."
  printf 'Usage: %s [-d|--duration <mins>] [-c|--color <color>] [-r|--rev-color <color>] [-w|--width <chars>] [--(no-)notify] [--(no-)sound] [--(no-)show] [--(no-)show-percentage] [-v|--version] [-h|--help] [--] [<task_name>]\n' "$0"
  printf '\t%s\n' "<task_name>: Pomodoro task name (default: 'Pomodoro')"
  printf '\t%s\n' "-d, --duration: Pomodoro time in mins (default: '25 ')"
  printf '\t%s\n' "-c, --color: Color of bar or None. Can be one of: 'Red', 'Green', 'Yellow', 'Blue' and 'None' (default: 'Blue ')"
  printf '\t%s\n' "-r, --rev-color: Color of revision bar or None. Can be one of: 'Red', 'Green', 'Yellow', 'Blue' and 'None' (default: 'Green ')"
  printf '\t%s\n' "-w, --width: Width of bar (default: '40 ')"
  printf '\t%s\n' "--notify, --no-notify: Notify with message (on by default)"
  printf '\t%s\n' "--sound, --no-sound: Notify with sound (on by default)"
  printf '\t%s\n' "--show, --no-show: Show time remaining (on by default)"
  printf '\t%s\n' "--show-percentage, --no-show-percentage: Show percentage of time remaining (off by default)"
  printf '\t%s\n' "-v, --version: Prints version"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\nEnvironment variables that are supported:\n'
  printf '\t%s\n' "NOTIFIER: The executable used to show notifications."
  printf '\t%s\n' "NOTIFY_TITLE: The notification header."
  printf '\t%s\n' "SPLAYER: The executable used to play sounds."
  printf '\t%s\n' "SND_DONE: The done sound file."
  printf '\t%s\n' "NO_COLOR: Disable color output (use any value)."

  printf '\n%s\n' "No more deep shits, just use the pomodoro timer."
}


# The parsing of the command-line
parse_commandline()
{
  _positionals_count=0
  while test $# -gt 0
  do
    _key="$1"
    # If two dashes (i.e. '--') were passed on the command-line,
    # assign the rest of arguments as positional arguments and bail out.
    if test "$_key" = '--'
    then
      shift
      # Handle the case when the double dash is the last argument.
      test $# -gt 0 || break
      _positionals+=("$@")
      _positionals_count=$((_positionals_count + $#))
      shift $(($# - 1))
      _last_positional="$1"
      break
    fi
    case "$_key" in
      # We support whitespace as a delimiter between option argument and its value.
      # Therefore, we expect the --duration or -d value.
      # so we watch for --duration and -d.
      # Since we know that we got the long or short option,
      # we just reach out for the next argument to get the value.
      -d|--duration)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_duration="$(nnint "$2" "duration")" || exit 1
        shift
        ;;
      # We support the = as a delimiter between option argument and its value.
      # Therefore, we expect --duration=value, so we watch for --duration=*
      # For whatever we get, we strip '--duration=' using the ${var##--duration=} notation
      # to get the argument value
      --duration=*)
        _arg_duration="$(nnint "${_key##--duration=}" "duration")" || exit 1
        ;;
      # We support getopts-style short arguments grouping,
      # so as -d accepts value, we allow it to be appended to it, so we watch for -d*
      # and we strip the leading -d from the argument string using the ${var##-d} notation.
      -d*)
        _arg_duration="$(nnint "${_key##-d}" "duration")" || exit 1
        ;;
      # See the comment of option '--duration' to see what's going on here - principle is the same.
      -c|--color)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_color="$(color "$2" "color")" || exit 1
        shift
        ;;
      # See the comment of option '--duration=' to see what's going on here - principle is the same.
      --color=*)
        _arg_color="$(color "${_key##--color=}" "color")" || exit 1
        ;;
      # See the comment of option '-d' to see what's going on here - principle is the same.
      -c*)
        _arg_color="$(color "${_key##-c}" "color")" || exit 1
        ;;
      # See the comment of option '--duration' to see what's going on here - principle is the same.
      -r|--rev-color)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_rev_color="$(color "$2" "rev-color")" || exit 1
        shift
        ;;
      # See the comment of option '--duration=' to see what's going on here - principle is the same.
      --rev-color=*)
        _arg_rev_color="$(color "${_key##--rev-color=}" "rev-color")" || exit 1
        ;;
      # See the comment of option '-d' to see what's going on here - principle is the same.
      -r*)
        _arg_rev_color="$(color "${_key##-r}" "rev-color")" || exit 1
        ;;
      # See the comment of option '--duration' to see what's going on here - principle is the same.
      -w|--width)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_width="$(nnint "$2" "width")" || exit 1
        shift
        ;;
      # See the comment of option '--duration=' to see what's going on here - principle is the same.
      --width=*)
        _arg_width="$(nnint "${_key##--width=}" "width")" || exit 1
        ;;
      # See the comment of option '-d' to see what's going on here - principle is the same.
      -w*)
        _arg_width="$(nnint "${_key##-w}" "width")" || exit 1
        ;;
      # The notify argurment doesn't accept a value,
      # we expect the --notify, so we watch for it.
      --no-notify|--notify)
        _arg_notify="on"
        test "${1:0:5}" = "--no-" && _arg_notify="off"
        ;;
      # See the comment of option '--notify' to see what's going on here - principle is the same.
      --no-sound|--sound)
        _arg_sound="on"
        test "${1:0:5}" = "--no-" && _arg_sound="off"
        ;;
      # See the comment of option '--notify' to see what's going on here - principle is the same.
      --no-show|--show)
        _arg_show="on"
        test "${1:0:5}" = "--no-" && _arg_show="off"
        ;;
      # See the comment of option '--notify' to see what's going on here - principle is the same.
      --no-show-percentage|--show-percentage)
        _arg_show_percentage="on"
        test "${1:0:5}" = "--no-" && _arg_show_percentage="off"
        ;;
      # See the comment of option '--notify' to see what's going on here - principle is the same.
      -v|--version)
        printf '%s %s\n\n%s\n' "cli_args.sh" ""${VERSION}"" ''
        exit 0
        ;;
      # We support getopts-style short arguments clustering,
      # so as -v doesn't accept value, other short options may be appended to it, so we watch for -v*.
      # After stripping the leading -v from the argument, we have to make sure
      # that the first character that follows coresponds to a short option.
      -v*)
        printf '%s %s\n\n%s\n' "cli_args.sh" ""${VERSION}"" ''
        exit 0
        ;;
      # See the comment of option '--notify' to see what's going on here - principle is the same.
      -h|--help)
        print_help
        exit 0
        ;;
      # See the comment of option '-v' to see what's going on here - principle is the same.
      -h*)
        print_help
        exit 0
        ;;
      *)
        _last_positional="$1"
        _positionals+=("$_last_positional")
        _positionals_count=$((_positionals_count + 1))
        ;;
    esac
    shift
  done
}


# Check that we receive expected amount positional arguments.
# Return 0 if everything is OK, 1 if we have too little arguments
# and 2 if we have too much arguments
handle_passed_args_count()
{
  test "${_positionals_count}" -le 1 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect between 0 and 1, but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


# Take arguments that we have received, and save them in variables of given names.
# The 'eval' command is needed as the name of target variable is saved into another variable.
assign_positional_args()
{
  local _positional_name _shift_for=$1
  # We have an array of variables to which we want to save positional args values.
  # This array is able to hold array elements as targets.
  # As variables don't contain spaces, they may be held in space-separated string.
  _positional_names="_arg_task_name "

  shift "$_shift_for"
  for _positional_name in ${_positional_names}
  do
    test $# -gt 0 || break
    eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
    shift
  done
}

# Call the function that assigns passed optional arguments to variables:
#  parse_commandline "$@"
# Then, call the function that checks that the amount of passed arguments is correct
# followed by the function that assigns passed positional arguments to variables:
#  handle_passed_args_count
#  assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash
# Validation of values



### END OF CODE GENERATED BY Argbash (sortof) ### ])
