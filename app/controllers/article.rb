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



def article(paper_arr,index2,page,data,semaphore,check,h)
	
	begin	    
		body2 = page.link_with(:href => data[index2]).click
	rescue
		puts "page not found!"
	else	
		body2 = body2.uri
		puts body2
		# page2 = agent.get body2
		html = Nokogiri::HTML(open(body2))
		puts html.title
		#puts "teacher's profile:",html.title
		my_teacher = teacher_name1(body2,h)
		puts "my_teacher",my_teacher

		paperhash = {:teachers_name => 'Anonymous', :bookss => 0, :journalss => 0, :confer_paperss => 0, :articless => 0}
		paperhash[:teachers_name] = my_teacher



		puts "-------------------------------------------------"


confer_arr = []
books_arr = []
journals_arr = []

    html.traverse do |node|
        if node.text?
            #if (node.content.include? "Publications") || (node.content.include? "Article")||
               #(node.content.include? "Journal")
                #(node.content.include? "Conference")
                if (node.content.include? "Vol.")
                    journals_arr.push(node.content)
                end 
                if (node.content.include? "Volume")
                    journals_arr.push(node.content)
                end 
                if (node.content.include? "Journal")
                    journals_arr.push(node.content)
                end
                if (node.content.include? "PLoS ONE")
                    journals_arr.push(node.content)
                end             
                if (node.content.include? "Transactions")
                    journals_arr.push(node.content)
                end                             
                if (node.content.include? "doi")
                    journals_arr.push(node.content)
                end                                             
                if (node.content.include? "springer")
                    journals_arr.push(node.content)
                end             
                if (node.content.include? "Impact Factor") || (node.content.include? "impact factor")
                    journals_arr.push(node.content)
                end             
            #end

            #if (node.content.include? "Books") || (node.content.include? "Book")
                if node.content.include? "ISBN"
                    puts "books",node.content
                    books_arr.push(node.content)
                end

            #end
            
            #if node.content.include? "Conference Papers"
                if (node.content.include? "Conference") || (node.content.include? "Conf.")
                    confer_arr.push(node.content)
                end 
                if (node.content.include? "Joint Conference")
                    confer_arr.push(node.content)
                end 
                if (node.content.include? "Exhibition")
                    confer_arr.push(node.content)
                end 
                if (node.content.include? "Proceeding")
                    confer_arr.push(node.content)
                end 
                if (node.content.include? "Proc.")
                    confer_arr.push(node.content)
                end
                if (node.content.include? "Conference Proceeding")
                    confer_arr.push(node.content)
                end
                if (node.content.include? "ISSN")  
                    confer_arr.push(node.content)
                end
                if (node.content.include? "symposium")  
                    confer_arr.push(node.content)
                end
            #end        
        end
    end

    puts my_teacher


    journals_arr = journals_arr.uniq
    puts "journals_arr.count #{journals_arr.count}"


    books_arr = books_arr.uniq
    puts "books_arr.count #{books_arr.count}"

    confer_arr = confer_arr.uniq
    puts "confer_arr.count #{confer_arr.count}"


    paperhash[:confer_paperss] = confer_arr.count
    paperhash[:bookss] = books_arr.count
    paperhash[:journalss] = journals_arr.count

    puts "articles",paperhash

	end #rescue end


	
	semaphore.synchronize{
		paper_arr.push(paperhash)
	}
    #return paper_arr
end

def papers(url,h)
	paper_arr = []
	a= url
	html,body1,page,check = facultyFinder(a)
	data=html.css('tr:contains("Professor") a').map { |a| a['href']}
	data2=html.css('tr:contains("Dr")').map{|a| a['href']}
	
	data3=html.css('li:contains("Professor") a').map { |a| a['href']}
	data4=html.css('li:contains("Dr")').map{|a| a['href']}
	
	data=data+data2+data3+data4
	data=data.uniq
	puts data
	
	books = ''
	next_count = ''
	next_count1 = ''
	next_count2 = ''
	next_count3 = ''
	pub = 0
	flag = true
	
	
	total_links=data.count
	puts total_links
	index2 = 0
	
	
	semaphore = Mutex.new
	threads = []
	
	while total_links>0 
	
		sleep(0.1)
		threads.push(Thread.new{article(paper_arr,index2,page,data,semaphore,check,h)})
		if (index2<data.count)
			# page = agent.get check
			html = Nokogiri::HTML(open(check))
			index2+=1
		end
		total_links-=1
		sleep(0.1)
	
	end
	i = 0
	while i<data.count
		threads[i].join
		i+=1
	end
	
    puts "paper_arr final"
	puts paper_arr
	return paper_arr
	
end
