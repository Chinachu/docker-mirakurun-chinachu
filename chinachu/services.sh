#!/bin/bash
if [ ! -s config.json ]; then
	cat config.sample.json > config.json
fi

rm -f /var/run/chinachu-operator.pid > /dev/null 2>&1
rm -f /var/run/chinachu-wui.pid > /dev/null 2>&1

countdown_max=300
run_countdown=0
while [ ${run_countdown} -le ${countdown_max} ]
do
	http_status=`curl -s container-mirakurun:40772/api/status -o /dev/null -w '%{http_code}'`
	if [ "${http_status}" = "200" ]; then
		run_countdown=0
		echo "mirakurun is run complete!"
		break
	fi
	run_countdown=`expr ${run_countdown} + 1`
	echo "wait for mirakurun to run...(${run_countdown}sec)"
	sleep 1
done

if [ ${run_countdown} -ge ${countdown_max} ]; then
	echo "mirakurun is timeout"
fi

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
