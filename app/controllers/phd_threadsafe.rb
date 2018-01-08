require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'net/http'
require 'cobravsmongoose'
require 'pp'
require 'HTTParty'
require 'mechanize'

# require 'Mechanize'
$VERBOSE = nil
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
@@phd_count1 = 0

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


def FindPhd (url,semaphore,page)

    begin
        puts url
        agent = Mechanize.new
        body = page.link_with(:href => url).click


    rescue
        puts "page not found11!"
    else    
        
        html = Nokogiri::HTML(open(body.uri))

        puts "teacher's profile:",html.title
                    
        html.traverse do |node|
            if node.text?
                if ((node.content.include? "PhD") || (node.content.include? "Dr.") || (node.content.include? "Ph.D") || (node.content.include? "PhD(CS)") || (node.content.include? "doctorate") || (node.content.include? "Ph.D."))
                    puts node.content                                                        
                    semaphore.synchronize{
                        @@phd_count1+=1
                        puts "phd_count",@@phd_count1   
                    }    
                    
                    break
                end
            end                 
        end
    
    end
end

def phd_faculty(url)
    a = url
    html,body1,page,check = facultyFinder(a)
        
    agent = Mechanize.new
    

    phd_count = 0
    index2=0
    
    semaphore = Mutex.new
    threads = []


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

    #unique case and could cause problems.

    if data1.count == 0
        puts "div Professor"
        data2=body1.css('div:contains("Professor") a').map { |a| a['href']} 
    end

    puts data1
    puts data1.count

    puts data2
    puts data2.count


    if data1.count != 0
        puts "IN THIS"
        total_links=data1.count
        flag = true
        index2 = 0

        while total_links>0 
            page10 = page
            threads.push(Thread.new{FindPhd(data1[index2],semaphore,page10)})
            sleep 0.2
            index2+=1
            total_links-=1 
        end
        x = 0
        while(x<data1.count)
            threads[x].join
            x+=1
        end
        puts "phd_count",@@phd_count1
        return @@phd_count1
    end


    if data1.count == 0
        puts "IN THIS 2"
        total_links=data2.count
        flag = true
        index2 = 0

        while total_links>0 
            page10 = page
            threads.push(Thread.new{FindPhd(data1[index2],semaphore,page10)})
            sleep 0.2
            index2+=1
            total_links-=1 
        end
        x = 0
        while(x<data2.count)
            threads[x].join
            x+=1
        end
        puts "phd_count",@@phd_count1
        return @@phd_count1
    end

    total_links=data1.count
    flag = true
    index2 = 0

    while total_links>0 
        sleep(0.1)
        threads.push(Thread.new{
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
                         semaphore.synchronize{
                            phd_count+=1
                            flag = false    
                         }                                    
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
        total_links-=1}) 
        sleep(0.1)
   
    end

    puts "phd_count",phd_count

    x = 0
    while(x<15)
        threads[x].join
        x+=1
    end 

    return phd_count

end

# phd = phd_faculty("https://sbasse.lums.edu.pk/department/computer-science")
