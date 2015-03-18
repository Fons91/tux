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

def get_grades_data()
      query_result = settings.mysqlhandler.mysqlQuery('SELECT NODE_NAME,STUD_NOTE,count(STUD_NOTE) FROM TUM_LEMORA.ATHENS_GRADES GROUP BY NODE_NAME, STUD_NOTE;')
      result = []
      query_result.each{ |row|
          single_result ={}
          single_result["name"]  = row[0].force_encoding('ISO-8859-1')
          single_result["grade"]  = row[1].force_encoding('ISO-8859-1')
          single_result["count"]  = row[2].force_encoding('ISO-8859-1')
          result << single_result
      }
      return result.to_json
end

def get_attendance_nonopt_data()
      query_result = settings.mysqlhandler.mysqlQuery('SELECT ATTENDANCE_ACTIVE_STUDENTS, DEGREE_NAME, NODE_NAME FROM TUM_LEMORA.ATHENS_NODE_ATT_ACTSTUD a JOIN TUM_LEMORA.ATHENS_NODE b ON a.NODE_ID = b.NODE_ID JOIN TUM_LEMORA.ATHENS_MODULE_NODE c ON a.NODE_ID = c.NODE_ID AND c.SUBJECT_TYPE_REFID = "PFLICHT" JOIN TUM_LEMORA.ATHENS_CURRICULUM_VERSION AS d ON d.STP_STP_NR = c.STP_STP_NR;')
      result = []
      query_result.each{ |row|
          single_result ={}
          single_result["attendance"]  = row[0].force_encoding('ISO-8859-1')
          single_result["degree"]  = row[1].force_encoding('ISO-8859-1')
          single_result["name"]  = row[2].force_encoding('ISO-8859-1')
          result << single_result
      }
      return result.to_json
end

def get_attendance_opt_data()
      query_result = settings.mysqlhandler.mysqlQuery('SELECT ATTENDANCE_ACTIVE_STUDENTS, DEGREE_NAME, NODE_NAME FROM TUM_LEMORA.ATHENS_NODE_ATT_ACTSTUD a JOIN TUM_LEMORA.ATHENS_NODE b ON a.NODE_ID = b.NODE_ID JOIN TUM_LEMORA.ATHENS_MODULE_NODE c ON a.NODE_ID = c.NODE_ID AND c.SUBJECT_TYPE_REFID != "PFLICHT" JOIN TUM_LEMORA.ATHENS_CURRICULUM_VERSION AS d ON d.STP_STP_NR = c.STP_STP_NR;')
      result = []
      query_result.each{ |row|
          single_result ={}
          single_result["attendanceO"]  = row[0].force_encoding('ISO-8859-1')
          single_result["degreeO"]  = row[1].force_encoding('ISO-8859-1')
          single_result["nameO"]  = row[2].force_encoding('ISO-8859-1')
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

get "/modulesoptional" do
  content_type :json
  get_attendance_opt_data
end
get "/modulesnonoptional" do
  content_type :json
  get_attendance_nonopt_data
end
get "/grades" do
  content_type :json
  get_grades_data
end

