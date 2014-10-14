module KrakenWorker

	require "json"
	require "rest_client"
	require "active_support/all"
	require "yaml"

	env = "development"
	TASKER_CONFIG = YAML.load(File.open("./config/config.yml"))[env]["tasker"]

	MIN_CYCLE_TIME = 0.3 #seconds
	HOST = "#{TASKER_CONFIG["host"]}:#{TASKER_CONFIG["port"]}"#"http://localhost:4567"

	def worker_loop
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
end