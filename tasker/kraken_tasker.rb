require "json"
require "./tasker/db_config"

init_db

class Worker < ActiveRecord::Base
end

get "/" do
	"Get to work, minions!"
end

get "/get_task" do
	worker = Worker.find_or_create_by(ip: request.ip)
	worker.requested = worker.requested.to_i + 1
	worker.last_request = Time.now
	worker.save

	Tasker.get_task.to_json
end

post "/complete_task" do
	worker = Worker.find_or_create_by(ip: request.ip)
	worker.completed = worker.completed.to_i + 1
	worker.save

	task = JSON.parse(params[:task])
	results = JSON.parse(params[:results])
	Tasker.complete_task(task, results)
	"Success"
end

get "/info" do
	@workers = Worker.all.sort_by(&:last_request).reverse
	@task_info = Tasker.task_info
	erb :info
end

