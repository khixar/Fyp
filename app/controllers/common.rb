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

def common(url)

	agent = Mechanize.new
	
	fac='\0'
	
	
	page = agent.get url
	html = Nokogiri::HTML(open(url))
	check=0
	check1 = ''
	body1 = ''
	faculty = ''
	fac = ''
	iid = 0
	id = ''
	if url.include? "id="
	    id = url[url.index('id='),url.length-1]
	    puts id
	end
	countttt =0
	parts = []
	while (url.include? "/") 
	    iid  = url[0,url.index('/')+1]
	    url.slice!(iid)
	    iid.slice! ("/")
	    parts.push(iid)
	end
	if (url.length>0)
	    parts.push(url)
	end
	if (parts[parts.length-1].include? "Faculty") || (parts[parts.length-1].include? "faculty")
	    temp = parts[parts.length-2]
	    temp << '/'
	    temp << parts[parts.length-1]
	    parts[parts.length-2] = parts[parts.length-3]
	    parts[parts.length-1] = temp
	    puts parts[parts.length-1]
	end

	html.traverse do |node|
	    if node.text?  
	      if node.content.include? "Faculty"
	              fac = node.parent.attributes['href'].to_s
	              if(fac=='')
	                  fac = node.parent.parent.attributes['href'].to_s
	              end
	              if(fac=='')
	                  fac = node.parent.parent.parent.attributes['href'].to_s
	              end
	              if ((fac.length>0) && (fac.include? id) && (id.length>0) && (fac[0]!='#')) 
	                  puts fac
	                  body1 = page.link_with(:href => fac).click
	                  check1 = fac
	                  check+=1
	                  break
	              end
	          end
	      end
	  end
	if(check == 0)
	html.traverse do |node|
	    if node.text?  
	      if node.content.include? "Faculty"
	              fac = node.parent.attributes['href'].to_s
	              if(fac=='')
	                  fac = node.parent.parent.attributes['href'].to_s
	              end
	              if(fac=='')
	                  fac = node.parent.parent.parent.attributes['href'].to_s
	              end
	              if ((fac.length>0) && (fac.include? parts[parts.length-1])  && (fac[0]!='#')) 
	                  puts fac
	                  body1 = page.link_with(:href => fac).click
	                  check1 = fac
	                  check+=1
	                  break
	              end
	          end
	      end
	  end
	end
	if(check == 0)
	html.traverse do |node|
	    if node.text?  
	      if node.content.include? "Faculty"
	              fac = node.parent.attributes['href'].to_s
	              if(fac=='')
	                  fac = node.parent.parent.attributes['href'].to_s
	              end
	              if(fac=='')
	                  fac = node.parent.parent.parent.attributes['href'].to_s
	              end
	              if ((fac.length>0) && (fac.include? parts[parts.length-2]) && (fac[0]!='#')) 
	                  puts fac
	                  body1 = page.link_with(:href => fac).click
	                  check1 = fac
	                  check+=1
	                  break
	              end
	          end
	      end
	  end
	end

	if (check == 0)
	    html.traverse do |node|
	    if node.text?  
	        if node.content.include? "Faculty"
	                fac = node.parent.attributes['href'].to_s
	                if(fac=='')
	                    fac = node.parent.parent.attributes['href'].to_s
	                end
	                if(fac=='')
	                    fac = node.parent.parent.parent.attributes['href'].to_s
	                end
	                if ((fac.length>0) && ((fac.include? 'department')  || (fac.include? 'dept') || (fac.include? 'Department')  ) && (fac[0]!='#')) 
	                    puts fac
	                    body1 = page.link_with(:href => fac).click
	                    check1 = fac
	                    check+=1
	                    break
	                end
	            end
	        end
	    end
	end
	if(check==0)
		html.traverse do |node|
			if node.text?  
				if node.content.include? "Faculty"
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
					body1 = page.link_with(:href => fac).click
					puts fac
					break	
				end
			end
		end
	end
	puts fac

    begin 

	   body1 = page.link_with(:href => fac).click

    rescue

        puts "Unable to find Faculty"
        #exit return response here.
        return 0,0,0,0

    else
	    check1 = fac  

    	if body1.body.length>0
    		faculty = body1.uri
    		check=faculty
    		page = agent.get faculty
    	end

    	html = Nokogiri::HTML(open(faculty))
    	#puts html
    	#puts html.title
    	return html,body1,page,check
    end

end	
