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

def return_research
	dept_url = params[:second]
	arr = []
	arr = JSON.parse(dept_url)
	#return_arr = []
	i = 0
	while (i < arr.length)
		return_arr.push(research(arr[i]))
		i+=1	
	end
	
	@ret_arr = return_arr
	render :json =>  @ret_arr.as_json()
end


def research(url)
	check=0
	check1 = ''
	body1 = ''
	res_arr = []

	total_groups = 0
	parser_count = 0
	flag = 0

	if parser_count == 0


		agent = Mechanize.new
		page = agent.get url
		html = Nokogiri::HTML(open(url))

		html.traverse do |node|
		  if node.text?  
		    if node.content.include? "Research"
					fac = node.parent.attributes['href'].to_s
					if(fac=='')
						fac = node.parent.parent.attributes['href'].to_s
					end
					if(fac=='')
						fac = node.parent.parent.parent.attributes['href'].to_s
					end
					if ((fac.length>0) && ((fac.include? 'Groups')  || (fac.include? 'groups') || (fac.include? 'Groups') ) && (fac[0]!='#')) 
						puts fac
						body1 = page.link_with(:href => fac).click 
						check1 = fac
						check+=1
						break
					end
				end
			end
		end
		if(check==0)
			html.traverse do |node|
				if node.text?  
					if node.content.include? "Research"
						fac = node.parent.attributes['href'].to_s
						if(fac=='')
							fac = node.parent.parent.attributes['href'].to_s
							body1 = page.link_with(:href => fac).click
							check1 = fac
						end
						if(fac=='')
							fac = node.parent.parent.parent.attributes['href'].to_s
							body1 = page.link_with(:href => fac).click
							check1 = fac
						end
						puts fac
						break	
					end
				end
			end
		end

		if body1.body.length>0
			faculty = body1.uri
			check=faculty
			page = agent.get faculty
		end

		html = Nokogiri::HTML(open(faculty))
		puts "this",html.title

		arr = ["h1","h2","h3","h4","h5","h6"]
		iter = 0
		total_groups = 0

		div_html = ''

		hhhh = 0

		#puts html.at(arr[1]).text
		html.traverse do |node|
			if node.text?
				#puts "yahan"
				if node.content.include? "Research Groups"
					puts "in research groups"
					puts node.parent.name
					if node.parent.name == "h2"
						puts "in h2"
						hhhh = node
						hhhh.traverse do |node2|
							if node2.text?
								if node2.name == "li"
									hhhh = node2
									break
								end
							end
							node2 = node2.child
						end
						#while hhhh.name!="div"
						#	hhhh = hhhh.parent
						#ssend
					end
				end
			end
		end

	research_count = 0
	res_arr = []

    puts "--------------------------------"
    puts hhhh

	hhhh.traverse do |node|
		if node.name== "li"
            puts "in li"
			puts node.content
			research_count+=1
			res_arr.push(node.content)
		end
	end
		puts "names"
		puts res_arr

		puts "research_count",research_count
		parser_count+=1

	end

	if (parser_count == 1 && res_arr.length == 0)
		agent = Mechanize.new
		page = agent.get url
		html = Nokogiri::HTML(open(url))
		check=0
		check1 = ''
		body1 = ''
		data=html.css('li:contains("Research") a').map { |a| a['href']}
		puts data

		i = 0
		link = []

		while (i < data.length)
			puts data[i]
			if data[i].include? "groups"
				link.push(data[i])
			end
			i+=1
		end

		puts link.first
    begin
		body1 = page.link_with(:href => link.first).click
    rescue
        puts "page not found!"
    else
		body1 = body1.uri
		page = agent.get body1
		html = Nokogiri::HTML(open(body1))

		puts "new title", html.title

		body = html.at('body').inner_html
		#puts body

		attrs = html.xpath('//a/@href')  # Get anchors w href attribute via xpath
		attrs.map {|attr| attr.value}

		puts attrs.length
		i = 0
		total_groups = 0

		attrs.each do |a|
			if a.to_s.include?("/groups")
				total_groups+=1
				puts "a.to_s",a.to_s
				res_arr.push(a.to_s)
			end
		end

		total_groups /= 2

		puts "total_groups1",total_groups

		total_groups = 0

		puts res_arr.uniq!

		puts res_arr.length

		i = 0

		while (i < res_arr.length)
			res_arr[i].slice!('/groups/')
			i+=1
		end

		puts res_arr
		total_groups = res_arr.length
    end #end rescue

	end

	res_arr.push(res_arr.length)

	return res_arr

end
