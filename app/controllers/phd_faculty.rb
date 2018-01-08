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

def phd_faculty(url)
    a = url
    html,body1,page,check = common(a)
    
    #i haven't test this code yet.

    if html == 0
        return 0 
    end
    
    agent = Mechanize.new
    

    phd_count = 0
    index2=0
    
    #semaphore = Mutex.new
    #threads = []


    data1 = []
    data2 = []
    data3 = []

#        puts "Dr Li"
    # data1=body1.css('li:contains("Dr") a').map { |a| a['href']}

    if data1.count == 0
        puts "li Professor"
        data1=body1.css('li:contains("Professor") a').map { |a| a['href']}
    end

#        puts data1

    # if data1.count == 0
    #     puts "td Dr"
    #     data1=body1.css('td:contains("Dr") a').map { |a| a['href']}
    # end

    if data1.count == 0
        puts "td Professor"
        data1=body1.css('td:contains("Professor") a').map { |a| a['href']} 
    end

#        puts data1


    # if data1.count == 0
    #     puts "div Dr"
    #     data1=body1.css('div:contains("Dr") a').map { |a| a['href']}
    # end

    if data1.count == 0
        puts "div Professor"
        data2=body1.css('div:contains("Professor") a').map { |a| a['href']} 
    end

    puts data1
    puts data1.count

    puts data2
    puts data2.count


    if data1.count == 0
        total_links=data2.count
        flag = true
        index2 = 0

        while total_links>0 
            #sleep(0.01)
            #threads.push(Thread.new{
            begin
                puts data2[index2]
                body2 = page.link_with(:href => data2[index2]).click

            rescue
                puts "page not found11!"
            else    
                body2 = body2.uri
                page = agent.get body2

                html = Nokogiri::HTML(open(body2))
                puts "teacher's profile:",html.title
                            
                
                html.traverse do |node|
                    if node.text?
                        if ((node.content.include? "PhD") || (node.content.include? "Ph.D") || (node.content.include? "PhD(CS)") || (node.content.include? "doctorate") || (node.content.include? "Ph.D.")) && (flag == true)
                            puts node.content                        
        #                   semaphore.synchronize{
                            phd_count+=1
                            flag = false    
        #                   }                                    
                            puts "phd_count",phd_count
                            break
                        end
                    end                 
                end
            end

            flag = true

            if (index2<data2.count)
            page = agent.get check
            html = Nokogiri::HTML(open(check))
                index2+=1
            end
            total_links-=1#}) 
            #sleep(0.01)
        end
        puts "phd_count",phd_count
        return phd_count
    end


=begin

    data1=body1.css('li:contains("Professor") a').map { |a| a['href']}
    puts data1
    if data1.count == 0
        data1=body1.css('td:contains("Professor") a').map { |a| a['href']}
        puts data1
    end
    if data1.count == 0
        data1=body1.css('div:contains("Professor") a').map { |a| a['href']}
        puts data1
    end
    data1 = data1.uniq
    puts data1

    puts data1.length

    puts data1.count

    return data1.length

=end        


    total_links=data1.count
    flag = true
    index2 = 0

    while total_links>0 
        #sleep(0.01)
        #threads.push(Thread.new{
        begin
            puts data1[index2]
            body2 = page.link_with(:href => data1[index2]).click

        rescue
            puts "page not found11!"
        else    
            body2 = body2.uri
            page = agent.get body2

            html = Nokogiri::HTML(open(body2))
            puts "teacher's profile:",html.title
                        
            
            html.traverse do |node|
                if node.text?
                    if ((node.content.include? "Dr") ||(node.content.include? "PhD") || (node.content.include? "Ph.D") || (node.content.include? "PhD(CS)") || (node.content.include? "doctorate") || (node.content.include? "Ph.D.")) && (flag == true)
                        puts node.content                        
    #                   semaphore.synchronize{
                        phd_count+=1
                        flag = false    
    #                   }                                    
                        puts "phd_count",phd_count
                        break
                    end
                end                 
            end
        end

        flag = true

        if (index2<data1.count)
        page = agent.get check
        html = Nokogiri::HTML(open(check))
            index2+=1
        end
        total_links-=1#}) 
        #sleep(0.01)
    end

    puts "phd_count",phd_count
    return phd_count

end
