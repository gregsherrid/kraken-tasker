# (c) Gregory Sherrid, 2014-10-7

require "json"
require "rest_client"
require "active_support/all"

worker_file = ENV['K_WORKER'] || "prime_worker"
require "./worker/#{worker_file}.rb"

MIN_CYCLE_TIME = 0.3 #seconds
HOST = "http://localhost:4567"

def main_loop
	i = 0

	get_task_url = "#{HOST}/get_task"
	complete_task_url = "#{HOST}/complete_task"

	while true
		puts "#{(i+=1).ordinalize} cycle"
		last_cycle = Time.now

		raw_task = RestClient.get get_task_url
		task = JSON.parse(raw_task)

		results = Worker.work(task)

		RestClient.post complete_task_url, task: task.to_json, results: results.to_json

		elapsed = Time.now - last_cycle
		if elapsed < MIN_CYCLE_TIME
			sleep(MIN_CYCLE_TIME - elapsed)
		end
	end
end

main_loop()