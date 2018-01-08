require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'net/http'
require 'cobravsmongoose'
require 'pp'
require 'HTTParty'

# require 'Mechanize'
$VERBOSE = nil
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def teacher_name(url)

associate = 0
whole = 0
teacher_name = ''
agent = Mechanize.new
page = agent.get url
html = Nokogiri::HTML(open(url))

	html.traverse do |node|
		if node.text?
			if (node.content.include? "Professor") || (node.content.include? "Lecturer")
				#puts node.content
				temp = node.parent
				#puts temp.name #h4
				whole = temp.parent.inner_html
				associate = temp.parent
				puts "associate",associate

				begin
					teacher_name = temp.previous.previous.content
					puts "teacher_name",teacher_name
				rescue
					#only for comsats so far..
					#puts "begin"

					if node.parent.parent.previous.previous?
						if node.parent.parent.previous.previous != nil
							teacher_name = node.parent.parent.previous.previous.content
						end
						break
					end
				else

				end
			end
		end
	end

	#puts teacher_name

	query = teacher_name.to_s

	query = query.split(' ')

	if query.length > 3
		temp = []
		temp.push(query[1])
		temp.push(query[2])
		temp.push(query[3])
		#puts temp
		return temp
	else		
		temp = []
		temp.push(query[1])
		temp.push(query[2])
		#puts temp
		return temp
	end

#	puts query[0]
#	puts query[1]
#	puts query[2]
#	puts query[3]
#	puts query.length

	return query

end
