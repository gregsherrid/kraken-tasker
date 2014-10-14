#!/bin/bash
FILE=workers.txt
KEY=~/.ssh/kraken-aws.pem
tar -cvf worker.tar worker config.yml Gemfile rakefile.rb

while read line; do
	HOST=ubuntu@$line

	scp -i $KEY worker.tar $HOST:~/worker.tar
	ssh -i $KEY -n $HOST 'tar -xvf worker.tar'
	ssh -i $KEY -n $HOST 'killall ruby'
	ssh -i $KEY -n $HOST 'sudo apt-get update'
	ssh -i $KEY -n $HOST 'sudo apt-get -y install libpq-dev'
	ssh -i $KEY $HOST 'bash -s' < ./scripts/ruby_setup.sh

	echo "-----------------------"
    echo "Deployed to $line"
	echo "-----------------------"
done < $FILE
