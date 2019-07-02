#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="myapp"
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
DOCKER_NAME="container-station"
DOCKER_ROOT=`/sbin/getcfg $DOCKER_NAME Install_Path -f ${CONF}`
APACHE_ROOT=`/sbin/getcfg SHARE_DEF defWeb -d Qweb -f /etc/config/def_share.info`
export QNAP_QPKG=$QPKG_NAME

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    : ADD START ACTIONS HERE
    $DOCKER_ROOT/bin/system-docker start myapp
    ;;

  stop)
    : ADD STOP ACTIONS HERE
    $DOCKER_ROOT/bin/system-docker stop myapp
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
