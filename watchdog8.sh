#!/bin/bash

#Tips welcome :) PYfnvSc9CRHCebGDtVkSijo6k7pCbpPthX

function launchptsminer {
	echo "######## Starting ptsminer... ########"
	cd /$HOME/ptsminer/src
	./ptsminer -poolip=ptsmine.beeeeer.org -poolport=1337 -poolpassword=0 -pooluser=PZTygehAqwKXwUQyCGRYpk9z56HKAzwVmp -genproclimit=8 > ~/ptsminer.log &
}

control_c()
{
	echo "######## Stopping  ########"
	ps aux | grep tail | grep ptsminer | awk  '{print "kill "$2}' | sh
	killall ptsminer
	exit 0
}
 
trap control_c SIGINT

mv ~/ptsminer.log ~/ptsminer.log.old 2> /dev/null

launchptsminer

tail -f ~/ptsminer.log &

while true
do
	grep "force reconnect" ~/ptsminer.log
	if [ $? -eq 0 ]
	then
		echo "######## Force reconnect DETECTED ########"
		echo "######## Killing ptsminer... ########"
		killall ptsminer
		echo "######## Wait 5 secs... ########"
		sleep 5s
		launchptsminer
	fi
	sleep 1s
done
