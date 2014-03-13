#!/bin/bash

# Apache Tomcat7: Start/Stop Chuong Trinh
#
# chkconfig: - 90 10




CATALINA_HOME=/var/www/tomcat7
TOMCAT_USER=tomcat
LOCKFILE=/var/lock/subsys/tomcat7

RETVAL=0
start(){
   echo "Khoi Dong Chuong Trinh: "
   su - $TOMCAT_USER -c "$CATALINA_HOME/bin/startup.sh"
   RETVAL=$?
   echo
   [ $RETVAL -eq 0 ] && touch $LOCKFILE
   return $RETVAL
}

stop(){
   echo "Ngat Chuong Trinh: "
   $CATALINA_HOME/bin/shutdown.sh
   RETVAL=$?
   echo
   [ $RETVAL -eq 0 ] && rm -f $LOCKFILE
   return $RETVAL
}

case "$1" in
   start)
      start
      ;;
   stop)
      stop
      ;;
   restart)
      stop
      start
      ;;
   status)
      status tomcat
      ;;
   *)
      echo $"Usage: $0 {start|stop|restart|status}"
      exit 1
      ;;
esac
exit $?