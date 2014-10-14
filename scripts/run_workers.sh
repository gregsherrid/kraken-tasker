#!/bin/bash
FILE=workers.txt
KEY=~/.ssh/kraken-aws.pem

while read line; do
	HOST=ubuntu@$line
	ssh -i $KEY -n $HOST 'screen -S worker -d -m ruby ./worker/kraken_worker.rb'

	echo "-----------------------"
    echo "Running $line"
done < $FILE

echo "-----------------------"
