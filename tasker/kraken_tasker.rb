# (c) Gregory Sherrid, 2014-10-6

require "sinatra"
require "sinatra/activerecord"
require "json"

tasker_file = ENV['K_TASKER'] || "prime_tasker"
require "./tasker/#{tasker_file}.rb"

def init_db
	db = URI.parse("postgres://kraken_tasker:kotsea@localhost/kraken_tasker_db")

	ActiveRecord::Base.establish_connection(
	  :adapter  => db.scheme == "postgres" ? "postgresql" : db.scheme,
	  :host     => db.host,
	  :username => db.user,
	  :password => db.password,
	  :database => db.path[1..-1],
	  :encoding => "utf8"
	)
end

init_db

get "/" do
	"Get to work, minions!"
end

get "/get_task" do
	Tasker.get_task.to_json
end

post "/complete_task" do
	task = JSON.parse(params[:task])
	results = JSON.parse(params[:results])
	Tasker.complete_task(task, results)
	puts "Success"
end

get "/tasker_info" do
	Tasker.task_info
end

