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

def foreign_phd_faculty(url)
    a = url
    html,body1,page,check = common(a)
    country_list = ["Afghanistan","Amsterdam","Texas","Purdue","Austin","Colorado","Ohio","London","UK","USA","Albania","Algeria","Andorra","Angola","Anguilla","Antigua","United Kingdom","USA","Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia", "Herzegovina","Botswana","Brazil","British Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica","Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre", "Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad "," Tobago","Tunisia","Turkey","Turkmenistan","Turks", "Caicos","Uganda","Ukraine","0United Arab Emirates","United Kingdom","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)","Yemen","Zambia","Zimbabwe", "United States", "Canada", "United States Minor Outlying Islands"]
    
    agent = Mechanize.new
    

    foreign_phd_count = 0
    parser_count = 0
    index2=0
    
    #semaphore = Mutex.new
    #threads = []


    if parser_count==0 
        
        puts "parser_count",parser_count

        puts "Dr Li"
        data1=body1.css('li:contains("Dr") a').map { |a| a['href']}

        if data1.count == 0
            puts "li Professor"
            data1=body1.css('li:contains("Professor") a').map { |a| a['href']}
        end

        puts data1

        if data1.count == 0
            puts "td Dr"
            data1=body1.css('td:contains("Dr") a').map { |a| a['href']}
        end

        if data1.count == 0
            puts "td Professor"
            data1=body1.css('td:contains("Professor") a').map { |a| a['href']} 
        end

        puts data1


        if data1.count == 0
            puts "div Dr"
            data1=body1.css('div:contains("Dr") a').map { |a| a['href']}
        end

        if data1.count == 0
            puts "div Professor"
            data1=body1.css('div:contains("Professor") a').map { |a| a['href']} 
        end

        puts data1


        #if data1 is still 0 then info is on the same page.



        total_links=data1.count

        flag = true


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
                index1=0
                
                
                html.traverse do |node|
                    if node.text?
                        if ((node.content.include? "PhD") || (node.content.include? "Ph.D") || (node.content.include? "PhD(CS)") || (node.content.include? "doctorate") || (node.content.include? "Ph.D.")) && (flag == true)
                            #puts node.content
                            total_array=country_list.count
                            index1=0                
                            while total_array>0
                                if node.content.include? country_list[index1]
                                    puts node.content                           
                #                   semaphore.synchronize{
                                    foreign_phd_count+=1
                                    flag = false    
                #                   }                                    
                                    puts "foreign_phd_count",foreign_phd_count
                                    break
                                end
                                total_array-=1
                                index1+=1
                            end
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
    end

    puts "foreign_phd_count",foreign_phd_count
    return foreign_phd_count

end
