sequence = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
months = Hash.new []
File.foreach("./page_views.txt") { |line|
month = line.split('/')[1]
months[month] += [line]
 }

output = File.open("./parsed_page_views.txt","w")

 sequence.each{|month|
  puts "--------------#{month}"
    months[month].each{|day|
        output.write day
    }

 }

 output.close()
