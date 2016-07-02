#!/bin/bash
/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start
tail -f /dev/null
