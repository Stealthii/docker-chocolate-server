#!/bin/sh
### BEGIN INIT INFO
# Provides: example-server
# Required-Start:	$syslog $local_fs $remote_fs 
# Required-Stop:	$syslog $local_fs $remote_fs 
# Short-Description: Example-Server
### END INIT INFO

. /lib/lsb/init-functions
prog=example-server
PIDFILE=/var/run/$prog.pid
DESC="Example-Server"
start() {
	log_daemon_msg "Starting $DESC" "$prog"
	start_daemon /usr/bin/docker kill example-server
	start_daemon /usr/bin/docker rm example-server
	start_daemon /usr/bin/docker pull stealthii/chocolate-server
	if [ $? -ne 0 ]; then
		log_end_msg 1
		exit 1
	fi
	start_daemon -p $PIDFILE /usr/bin/docker run \
	start_daemon -p $PIDFILE -name example-server \
	start_daemon -p $PIDFILE -memory 33554432b \
	start_daemon -p $PIDFILE p 0.0.0.0:2342:2342/udp \
	start_daemon -p $PIDFILE e "port=2342" \
	start_daemon -p $PIDFILE e "privateserver=false" \
	start_daemon -p $PIDFILE e "servername=Docker Doom Server" \
	start_daemon -p $PIDFILE stealthii/chocolate-server
	if [ $? -ne 0 ]; then
		log_end_msg 1
		exit 1
	fi
	if [ $? -eq 0 ]; then
		log_end_msg 0
	fi
	exit 0
}

stop() {
	log_daemon_msg "Stopping $DESC" "$prog"
	/usr/bin/docker stop example-server
	if [ $? -ne 0 ]; then
		log_end_msg 1
		exit 1
	fi
	if [ $? -eq 0 ]; then
		log_end_msg 0
	fi
}

force_reload() {
	stop
	start

}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	force-reload)
		force_reload
		;;
	restart)
		stop
		start
		;;

	*)
		echo "$Usage: $prog {start|stop|force-reload|restart}"
		exit 2
esac
