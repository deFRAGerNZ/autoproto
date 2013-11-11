#!/bin/bash

# Tips welcome :) PYfnvSc9CRHCebGDtVkSijo6k7pCbpPthX

function launchptsminer {
        echo "######## Starting ptsminer... ########"
        cd /$HOME/ptsminer/src
        tsocks ./ptsminer -poolip=ptsmine.beeeeer.org -poolport=1337 -poolpassword=helloworldtest -pooluser=PZTygehAqwKXwUQyCGRYpk9z56HKAzwVmp -genproclimit=4 > ~/ptsminer.log &
}

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
