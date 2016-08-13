#!/bin/bash
if [ ! -f /usr/local/etc/mirakurun/channels.yml ]; then
	cat /usr/local/share/mirakurun/channels.yml > /usr/local/etc/mirakurun/channels.yml
fi
if [ ! -f /usr/local/etc/mirakurun/tuners.yml ]; then
	cat /usr/local/share/mirakurun/tuners.yml > /usr/local/etc/mirakurun/tuners.yml
fi
if [ ! -f /usr/local/etc/mirakurun/server.yml ]; then
	cat /usr/local/share/mirakurun/server.yml > /usr/local/etc/mirakurun/server.yml
fi

pcscd
/usr/bin/mirakurun start
/usr/bin/mirakurun log server
