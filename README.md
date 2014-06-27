environment-manager
===================

A small bash tool to manage different working environments with different settings, environment variables, etc.

Usage
-----

Put the following in your .bashrc:

    export ENVMAN_BASEDIR=/path/to/environment/location
    source /path/to/environment-manager/envman_setup.bash

Setup an environment by creating a .sh file in `$ENVMAN_BASEDIR/`. Files not ending in `.sh`
will be ignored. 

Commands:
- `envman list` lists available environments.
- `envman go NAME` will open a new shell with the specified environment.
- `envman edit NAME` will open an editor with the configuration file of the specified environment.

