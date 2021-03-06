#!/bin/bash

set -e
# Include settings to any bash script
#
# Reads:
#   ../configs/settings.ini
#
# Sets:
#   $HW__general__sitename
#   $HW__general__metanamespace
#   $HW__general__domain
#   $HW__db__host
#   $HW__db__username
#   $HW__db__password
#   $HW__db__database
#   $HW__db__prefix
# among others
#
# Usage:
#   "source scripts/_path_resolve.sh" # settings.sh relies on path variables being set
#   "source scripts/_settings.sh"
#

# SCRIPTDIR can be set outside this script as well
# That's the case when using this from inside vagrant
if [ -z "${SCRIPTDIR+x}" ]; then
  SCRIPTDIR="$(dirname "$0")"
fi

SETTINGSFILE="$SCRIPTDIR/../configs/settings.ini"

# If we don't have settings.ini, copy example
if [ ! -f "$SETTINGSFILE" ]; then
  echo ""
  echo "Create configs/settings.ini"
  cp -i "$SCRIPTDIR/../configs/settings-example.ini" "$SCRIPTDIR/../configs/settings.ini"
fi

# Make sure Bash ini parser is installed
if [ ! -d "$SCRIPTDIR/vendor/bash_ini_parser" ]; then
  echo ""
  echo "Installing Bash ini parser..."
  git clone https://github.com/pmgouveia/bash_ini_parser.git "$SCRIPTDIR/vendor/bash_ini_parser"
fi

# Load parser
source "$SCRIPTDIR/vendor/bash_ini_parser/read_ini.sh"

# Read settings and expose them
read_ini "$SETTINGSFILE" -p HW
