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


def programs_offered(url)
	puts "helllo"
	@policy = File.read(RAILS_ROOT + '/config/my_policy.txt')
	puts @policy
	return 1

	group_count = 0
	check=0
	check1 = ''
	body1 = ''

	parser_count = 0
	flag = 0

	if parser_count == 0
		agent = Mechanize.new
		page = agent.get url
		fac='\0'
		html = Nokogiri::HTML(open(url))
		check=0	
		check1 = ''
		body1 = ''

		html.traverse do |node|
			if node.text?  
				if node.content.include? "Academic"
					fac = node.parent.attributes['href'].to_s
					if(fac=='')
						fac = node.parent.parent.attributes['href'].to_s
					end
					if(fac=='')
						fac = node.parent.parent.parent.attributes['href'].to_s
					end
					if ((fac.length>0) && ((fac.include? 'Academic Programmes')  || (fac.include? 'Academic')) && (fac[0]!='#')) 
						check+=1
						puts fac
						break
					end
				end
			end
		end
		if(check==0)
			html.traverse do |node|
				if node.text?  
					if node.content.include? "Academic Programmes"
						fac = node.parent.attributes['href'].to_s
						if(fac=='')
							fac = node.parent.parent.attributes['href'].to_s
						end
						if(fac=='')
							fac = node.parent.parent.parent.attributes['href'].to_s
						end
						if ((fac.length>0) && (fac[0]!='#'))
							puts fac
							break
						end 
					end     
				end
			end
		end

		body1 = page.link_with(:href => fac).click
		check1 = fac  

		if body1.body.length>0
			faculty = body1.uri
			check=faculty
			page = agent.get faculty
		end

		html = Nokogiri::HTML(open(faculty))
		#puts html
		puts html.title
		div_html = []

		#div_html = html.css('img').collect(&:to_s) #=> ["<img src=\"example.jpg\">"] 

		#puts div_html

		#puts div_html.count



		html.traverse do |node|
			if node.text?
				if node.content.include? "Academic Programmes"
					if node.parent.name == 'h1'
						puts node.parent.parent.name
						div_html = node.parent.parent.children.inner_html    
					end
				end
			end
		end

		puts "div_html",div_html

		if div_html.include? "img"
			total_programs = div_html.scan(/img/).count
		end

		puts "total_programs",total_programs


		group_count = total_programs

		parser_count+=1

	end

	if ((parser_count == 1) && (group_count != 0))
		
		agent = Mechanize.new
		page = agent.get url
		fac='\0'
		html = Nokogiri::HTML(open(url))
		check=0	
		check1 = ''
		body1 = ''

		html.traverse do |node|
			if node.text?  
				if node.content.include? "Academics"
					fac = node.parent.attributes['href'].to_s
					if(fac=='')
						fac = node.parent.parent.attributes['href'].to_s
					end
					if(fac=='')
						fac = node.parent.parent.parent.attributes['href'].to_s
					end
					if ((fac.length>0) && ((fac.include? 'Academic Programmes')  || (fac.include? 'Academic')) && (fac[0]!='#')) 
						check+=1
						puts fac
						break
					end
				end
			end
		end
		if(check==0)
			html.traverse do |node|
				if node.text?  
					if node.content.include? "Academic Programmes"
						fac = node.parent.attributes['href'].to_s
						if(fac=='')
							fac = node.parent.parent.attributes['href'].to_s
						end
						if(fac=='')
							fac = node.parent.parent.parent.attributes['href'].to_s
						end
						if ((fac.length>0) && (fac[0]!='#'))
							puts fac
							break
						end 
					end     
				end
			end
		end

		body1 = page.link_with(:href => fac).click
		check1 = fac  

		if body1.body.length>0
			faculty = body1.uri
			check=faculty
			page = agent.get faculty
		end

		html = Nokogiri::HTML(open(faculty))
		#puts html
		puts html.title


		#data = html.css('li:contains("Programs") a').map { |a| a['href']}
		#puts data
		#puts data.count  

		div_html = []


		html.traverse do |node|
			if node.text?
				if node.content.include? "Programs"
					puts node.parent.name
					if node.parent.name == 'a' 
						puts node.parent.parent.name
						div_html = node.parent.parent.inner_html
					end
				end
			end
		end



		puts "div_html",div_html

		if div_html.include? "li"
			total_programs = div_html.scan(/li/).count
		end
		total_programs /= 2
		puts total_programs
		total_programs = group_count
		puts group_count

	end
	return group_count
end

