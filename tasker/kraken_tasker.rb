# (c) Gregory Sherrid, 2014-10-6

require 'sinatra'
require 'sinatra/activerecord'

db = URI.parse('postgres://kraken_tasker:kotsea@localhost/kraken_tasker_db')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

get '/' do
	"Get to work, minions!"
end