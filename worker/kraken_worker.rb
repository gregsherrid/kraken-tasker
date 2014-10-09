# (c) Gregory Sherrid, 2014-10-7

require "json"
require 'net/http'
require "active_support/all"

worker_file = ENV['K_WORKER'] || "prime_worker"
require "./worker/#{worker_file}.rb"

MIN_CYCLE_TIME = 0.3 #seconds
HOST = "http://localhost:9393"

def main_loop
	i = 0

	task_url = URI.parse("#{HOST}/get_task")

	while true
		puts "#{(i+=1).ordinalize} cycle"
		last_cycle = Time.now

		task = JSON.parse(Net::HTTP.get(task_url))
		results = Worker.work(task)
		response = {task: task, results: results}.to_json
		puts response

		elapsed = Time.now - last_cycle
		if elapsed < MIN_CYCLE_TIME
			sleep(MIN_CYCLE_TIME - elapsed)
		end
	end
end

main_loop()