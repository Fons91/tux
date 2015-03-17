require 'sinatra'
require 'json'
require 'mysql'


class MysqlCon
 def initialize
 	begin
            user = ENV["athens_user"]
            password = ENV["athens_pass"]
            puts "user #{user}"

 		@connection = Mysql.new 'localhost', user , password
	rescue Mysql::Error => e
    	   puts e.errno
    	   puts e.error
	end
 end
 def mysqlQuery (query)
 	result = @connection.query(query)
 	output = result.fetch_row
 #	@connection.close if @connection
 	return output
 end
end

set :public_folder, "./public"

def init()
	begin
	    con = Mysql.new 'localhost', 'root', 'password2'
	    puts con.get_server_info
	    rs = con.query 'SELECT VERSION()'
	    puts rs.fetch_row

	rescue Mysql::Error => e
	    puts e.errno
	    puts e.error
	ensure
	    con.close if con
	end
end

mysqlhandler = MysqlCon.new()
puts mysqlhandler.mysqlQuery('SELECT VERSION()')
puts "hello"
puts mysqlhandler.mysqlQuery('SELECT VERSION()')

def get_modules_data()
  "hello".to_json
end

get '/' do
 # erb :index,  :locals => {:data => data}
  send_file File.join(settings.public_folder, 'index.html')
end



get "/modules" do

  content_type :json
  get_modules_data
end


