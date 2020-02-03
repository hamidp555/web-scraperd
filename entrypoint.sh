#!/bin/sh
set -e
set -x

# use exec so that supervisord becomes the container’s PID 1. 
# supervisord is the parent process that handles all other child processes inside the container
# this setup is crucial in order to be able to kill this container with SIGTERM (and not SIGKILL)
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisor.conf