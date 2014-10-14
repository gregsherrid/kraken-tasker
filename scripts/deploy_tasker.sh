HOST=ubuntu@ec2-54-69-219-155.us-west-2.compute.amazonaws.com
KEY=~/.ssh/kraken-aws.pem

tar -cvf tasker.tar tasker config.yml Gemfile rakefile.rb

scp -i $KEY tasker.tar $HOST:~/tasker.tar
ssh -i $KEY $HOST 'tar -xvf tasker.tar'
ssh -i $KEY $HOST 'killall ruby'
ssh -i $KEY $HOST 'sudo apt-get -y install libpq-dev'
ssh -i $KEY $HOST 'bash -s' < ./scripts/ruby_setup.sh
ssh -i $KEY $HOST 'screen -S tasker -d -m ruby ./tasker/kraken_tasker.rb -o 0.0.0.0'