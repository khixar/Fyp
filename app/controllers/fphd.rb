require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'net/http'
require 'cobravsmongoose'
require 'pp'
require 'HTTParty'
require 'mechanize'
$VERBOSE = nil
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

@@phd_count2 = 0
#COUNTRY_LIST = ["Afghanistan","Amsterdam","Texas","Purdue","Austin","Colorado","Ohio","London","UK","USA","Albania","Algeria","Andorra","Angola","Anguilla","Antigua","United Kingdom","USA","Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia", "Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre", "Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad "," Tobago","Tunisia","Turkey","Turkmenistan","Turks", "Caicos","Uganda","Ukraine","0United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe", "United States", "Canada", "United States Minor Outlying Islands"]

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



def FindForeignPhd (url,semaphore,page)
    flag = true
country_arr = ["Afghanistan","Amsterdam","Texas","Purdue","Austin","Colorado","Ohio","London","UK","USA","Albania","Algeria","Andorra","Angola","Anguilla","Antigua","United Kingdom","USA","Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia", "Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre", "Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad "," Tobago","Tunisia","Turkey","Turkmenistan","Turks", "Caicos","Uganda","Ukraine","0United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe", "United States", "Canada", "United States Minor Outlying Islands"]


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
                if ((node.content.include? "PhD") ||(node.content.include? "Dr.") || (node.content.include? "Ph.D") || (node.content.include? "PhD(CS)") || (node.content.include? "doctorate") || (node.content.include? "Ph.D.")) && (flag == true)
                    #puts node.
                    total_array = country_arr.count
                    puts total_array
                    index1=0                
                    while total_array>0
                        if node.content.include? country_arr[index1]
                            puts node.content                           
                            semaphore.synchronize{
                                @@phd_count2+=1
                                puts "foreign_phd_count",@@phd_count2
                                flag = false   
                            }    
                            
                            break
                        end
                        total_array-=1
                        index1+=1
                    end
                end
            end                 
        end
        flag = true
    end

end



def foreign_phd_faculty(url)
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
        data1=html.css('li:contains("Professor") a').map { |a| a['href']}
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
            puts "start"
            threads.push(Thread.new{FindForeignPhd(data1[index2],semaphore,page10)})
            sleep 0.2
            index2+=1
            total_links-=1 
        end
        x = 0
        while(x<data1.count)
            threads[x].join
            x+=1
        end
        puts "phd_count",@@phd_count2
        phd_count = @@phd_count2
        @@phd_count2 = 0
        return phd_count
    end

    if data1.count == 0
        puts "IN THIS 2"
        total_links=data2.count
        flag = true
        index2 = 0

        while total_links>0 
            page10 = page
            puts "start"
            threads.push(Thread.new{FindForeignPhd(data1[index2],semaphore,page10)})
            sleep 0.2
            index2+=1
            total_links-=1 
        end
        x = 0
        while(x<data2.count)
            threads[x].join
            x+=1
        end
        puts "phd_count",@@phd_count2
        phd_count = @@phd_count2
        @@phd_count2 = 0
        return phd_count
    end
end