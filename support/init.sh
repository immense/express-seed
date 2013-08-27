#!/bin/sh

#
# chkconfig: 35 99 99
# description: Run {{applicationName}}
#

. /etc/rc.d/init.d/functions

USER="{{applicationUser}}"
APP_NAME="{{applicationName}}"

ROOT_DIR="/home/$USER/sites/$APP_NAME"
COMMAND="npm start"
SERVER="$ROOT_DIR/app.coffee"

LOCK_FILE="/var/lock/subsys/$USER-$APP_NAME"

do_start()
{
  if [ ! -f "$LOCK_FILE" ] ; then
    echo -n $"Starting $SERVER: "
    runuser -l "$USER" -c "cd $ROOT_DIR && $COMMAND > /dev/null 2>&1" && echo_success || echo_failure
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch $LOCK_FILE
  else
    echo "$SERVER is locked."
    RETVAL=1
  fi
}
do_stop()
{
  echo -n $"Stopping $SERVER: "
  runuser -l "$USER" -c "forever stopall" && echo_success || echo_failure
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && rm -f $LOCK_FILE
}

case "$1" in
  start)
    do_start
    ;;
  stop)
    do_stop
    ;;
  restart)
    do_stop
    do_start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    RETVAL=1
esac

exit $RETVAL