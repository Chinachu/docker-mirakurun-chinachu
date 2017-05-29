#!/bin/bash
if [ ! -s /usr/local/etc/mirakurun/channels.yml ]; then
	cat /usr/local/share/mirakurun/channels.yml > /usr/local/etc/mirakurun/channels.yml
fi
if [ ! -s /usr/local/etc/mirakurun/tuners.yml ]; then
	cat /usr/local/share/mirakurun/tuners.yml > /usr/local/etc/mirakurun/tuners.yml
fi
if [ ! -s /usr/local/etc/mirakurun/server.yml ]; then
	cat /usr/local/share/mirakurun/server.yml > /usr/local/etc/mirakurun/server.yml
fi

rm -f /run/pcscd/pcscd.comm >/dev/null 2>&1

pcscd -f --error &
npm start
