#!/bin/bash
FILE=workers.txt
KEY=~/.ssh/kraken-aws.pem

while read line; do
	HOST=ubuntu@$line

	ssh -i $KEY -n $HOST 'killall ruby'

	echo "-----------------------"
    echo "Stopped $line"
done < $FILE

echo "-----------------------"
