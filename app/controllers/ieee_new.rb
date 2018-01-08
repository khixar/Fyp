require 'open-uri'
require 'JSON'

url = URI.parse('http://ieeexploreapi.ieee.org/api/v1/search/articles?parameters&author=Ali Afzal Malik&apikey=sswrp8ecxvyscdu4zf9vxssh')
response = ''
open(url) do |http|
  response = http.read
  #puts "response: #{response.inspect}"

end

hasher = JSON.parse(response)
#puts "----------",hasher

total = hasher['total_records']

articles1 = []
i = 0
while i < total
	articles1.push(hasher['articles'][i]['title'])
	i+=1	
end

puts articles1
puts articles1.count

ter+=1
