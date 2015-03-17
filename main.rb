require 'sinatra'
require 'json'



set :public_folder, "./public"

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


