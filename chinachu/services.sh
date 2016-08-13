#!/bin/bash
rm -f /var/run/chinachu-operator.pid
/etc/init.d/chinachu-operator start
rm -f /var/run/chinachu-wui.pid
/etc/init.d/chinachu-wui start
tail -f /dev/null
