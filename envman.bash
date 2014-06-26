#!/bin/bash -i

# CONFIGURATION OPTIONS
# ENVMAN_BASEDIR=...
# SHELL=...

ENVMAN_ENV_DIR=$ENVMAN_BASEDIR/envs
ENVMAN_INCLUDE_DIR=$ENVMAN_BASEDIR/include

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

    echo Begin working in env \'$2\'
    echo Sourcing file \'$ENV_FILE\'
    source $ENV_FILE

    source ~/.bashrc
    source /etc/bashrc

    export PS1="${PS1} (\e[0;34m$2\e[0m) "

    $SHELL -i
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