#!/bin/bash
if [ ! -f /usr/local/chinachu/conf/config.json ]; then
	cat /usr/local/chinachu/config.sample.json > /usr/local/chinachu/conf/config.json
fi

rm -f /var/run/chinachu-operator.pid > /dev/null 2>&1
rm -f /var/run/chinachu-wui.pid > /dev/null 2>&1

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
