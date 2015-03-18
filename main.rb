require 'sinatra'
require 'json'
require 'mysql'


class MysqlCon
 def initialize
 	begin
            user = ENV["athens_user"]
            password = ENV["athens_pass"]
 		@connection = Mysql.new 'localhost', user , password
	rescue Mysql::Error => e
    	   puts e.errno
    	   puts e.error
	end
 end
 def mysqlQuery (query)
      result = []
 	query_result = @connection.query(query)
 end
end

set :public_folder, "./public"
set :mysqlhandler , MysqlCon.new()

def get_semester_data()
      query_result = settings.mysqlhandler.mysqlQuery('SELECT NODE_NAME,STUD_SEM,COUNT(*)  FROM TUM_LEMORA.ATHENS_GRADES GROUP by STUD_SEM,NODE_NAME;')
      result = []
      query_result.each{ |row|
          single_result ={}
          single_result["node"]  = row[0].force_encoding('ISO-8859-1')
          single_result["sem"]  = row[1].force_encoding('ISO-8859-1')
          single_result["count"]  = row[2].force_encoding('ISO-8859-1')
          result << single_result
      }
      return result.to_json
end




get '/' do
 # erb :index,  :locals => {:data => data}
  send_file File.join(settings.public_folder, 'index.html')
end



get "/semester" do
  content_type :json
  get_semester_data
end


