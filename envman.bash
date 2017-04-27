#!/bin/bash -i

# CONFIGURATION OPTIONS
# ENVMAN_BASEDIR=...
# SHELL=...

ENVMAN_ENV_DIR=$ENVMAN_BASEDIR/

# figure out directory of this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PRE_SOURCE_HOOK=$DIR/"pre-source-hook.bash"

case $1 in
  go)
	if [ -N $2 ]; then
		echo "ERROR: No environment name given"
		exit -1
	fi

	ENV_FILE=$ENVMAN_ENV_DIR/$2.sh

	if [ ! -f $ENV_FILE ]; then
		echo "ERROR: environment '$2' does not exist"
		exit -2
	fi

	#source $ENV_FILE

	ENVMAN_ENV_DIR="${ENVMAN_ENV_DIR}" ENV_FILE="${ENV_FILE}" PS1="${PS1} (\\[\\[\\e[0;34m\\]$2\\[\\e[m\\]\\]) " $SHELL --rcfile $PRE_SOURCE_HOOK
    ;;
  list)
	for x in $(cd $ENVMAN_ENV_DIR && find . -type f -iname "*.sh"); do
		x_without_ext=${x%.*}
		echo ${x_without_ext:2}
	done
	;;
  edit)
	if [ -N $2 ]; then
		echo "ERROR: No environment name given"
		exit -1
	fi

	ENV_FILE=$ENVMAN_ENV_DIR/$2.sh

	if [ ! -f $ENV_FILE ]; then
		echo "ERROR: environment '$2' does not exist"
		exit -2
	fi

	$EDITOR $ENV_FILE    
esac
