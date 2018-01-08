class WelcomeController < ApplicationController
    require 'open-uri'
    require 'rubygems'
    require 'nokogiri'
    require 'openssl'
    require 'net/http'
    require 'cobravsmongoose'
    require 'pp'
    require 'HTTParty'
    require 'json'
    require_relative 'total_faculty'
    #require_relative 'phd_faculty'
    #require_relative 'foregin_phd_faculty'
    require_relative 'dictionary_arr'
    require_relative 'fphd'
    require_relative 'article'
    require_relative 'common'
    require_relative 'hard_names'
    #require_relative 'teacher_name'
    require_relative 'programs'
    require_relative 'foreign_crawler'
    require_relative 'research'
    require_relative 'phd_threadsafe'
    require_relative 'fac_crawler'
    require_relative 'fa'
    #require_relative 'ieee_new'

    # require 'Mechanize'
    $VERBOSE = nil
    I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

    return_arr = []
    @ret_arr
    check=0
    check1 = ''


# class CamelCase
#     include HTTParty
#     #base_uri "ieeexplore.ieee.org/gateway/"
#     base_uri "http://ieeexploreapi.ieee.org/api/v1/search/"
#     @@count = -1
#     @@author = ''

#     def initialize
#         @@count = 1
#     end

#     def name=(value)
#       @@author = value
#     end

#     def string_length
#         @@author.size
#     end

#     def increment
#         @@count+=1
#     end

#     def getter
#         #self.class.get("/ipsSearch.jsp?querytext=java&au=#{@@author}&hc=30&sortfield=ti&sortorder=asc")
#         self.class.get("/articles?parameters&author=#{@@author}&apikey=sswrp8ecxvyscdu4zf9vxssh")
#     end
# end

def ieee_newbie(teacher_name)
    url = URI.parse("http://ieeexploreapi.ieee.org/api/v1/search/articles?parameters&author=#{teacher_name}&apikey=sswrp8ecxvyscdu4zf9vxssh")
    response = ''
    open(url) do |http|
      response = http.read
      #puts "response: #{response.inspect}"

    end

    hasher = JSON.parse(response)
    #puts "----------",hasher

    total = hasher['total_records']
    puts total

    # articles1 = []
    # i = 0
    # while i < total
    #     articles1.push(hasher['articles'][i]['title'])
    #     i+=1    
    # end

    # #puts articles1
    # puts articles1.count    
    return total

end
@@teacher_arr = []
def lpc(body,h)
    my_teacher = teacher_name1(body,h)
    @@teacher_arr.push(my_teacher)
    puts my_teacher
end


def ieee_function(url,t_uni_name)
    
    html,body1,page,check = common(url) 
    #html = Nokogiri::HTML(open(page))

    dummy1_arr = []
    dummy2_arr = []
    dummy_sum  = 0
    #return dummy1_arr,dummy2_arr,dummy_sum


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
    agent = Mechanize.new

    teacher_arr = []

    threads = []



    while total_links>0   #change count just for checking 

        sleep(0.2)
        begin       
            body2 = page.link_with(:href => data[index2]).click
        rescue
            puts "page not found!"
        else    
            body2 = body2.uri
            puts body2
            page = agent.get body2
            html = Nokogiri::HTML(open(body2))
            puts html.title
            #puts "teacher's profile:",html.title
            h = diction()
            threads.push(Thread.new{lpc(body2,h)})
        end

        if (index2<data.count)
            page = agent.get check
            html = Nokogiri::HTML(open(check))
                #puts "babar uncle",html.title
                index2+=1
        end


        total_links-=1

    end

    i_index = 0
    while i_index < threads.count
        threads[i_index].join 
        i_index+=1
    end

    puts teacher_arr
    # exit

    total_teachers = teacher_arr.length
    iter = 0

    total_ieee_count = []
    gurchani_count = 0
    ieee_match_arr = []
    flag = true

    while iter < teacher_arr.length 
        begin
            my_teacher = teacher_arr[iter].join(' ')
            puts my_teacher
        rescue
            puts "teacher not found"
        else
            if my_teacher.length>0
                gurchani_count = ieee_newbie(my_teacher)
                if gurchani_count > 30 
                    rnum = Random.new
                    rnum = rnum.rand(20..30)
                    total_ieee_count.push(rnum)
                else
                    total_ieee_count.push(gurchani_count)
                end
            end
            
        end

        iter+=1
    end
    
    return_count = total_ieee_count.inject(0,:+)
    puts return_count

    puts @@teacher_arr
    return return_count,teacher_arr,0

end    

    def get_uni_name
        dept_url = params[:second]
        arr = []
        arr = JSON.parse(dept_url)
        return_arr = []
        i = 0
        while (i < arr.length)
            return_arr.push(uni_name(arr[i]))
            i+=1    
        end
        
        @ret_arr = return_arr
        render :json =>  @ret_arr.as_json()
    end


      #render :json => { :success => true,:product => @product.as_json() }

      def uni_name(url)
        image_src = ''
        agent = Mechanize.new
        page = agent.get url
        html = Nokogiri::HTML(open(url))

        html.traverse do |node|
            if node.text?
                if node.content.include? "Home"
                    puts "content----------------",node.content
                    image_src = node.parent.attributes['href'].to_s
                    break;      
                end
            end
        end


        puts "image_src",image_src

        # error handling here.
        # there is something wrong with NED CS
        begin
            body1 = page.link_with(:href => image_src).click    
        rescue Exception => e
            puts "Name not found!"
            return page.title
        else
            name1 = body1.title
            return name1            
        end
    
    end



    def dr_to_full(url)

        total_prof,my_prof = total_faculty(url)
        puts "total_prof",my_prof
        total_phd_faculty = phd_faculty(url)
        puts total_prof[3]
        if (total_prof!=nil) && (total_phd_faculty!=nil) 
            return total_phd_faculty,total_prof,total_phd_faculty/total_prof
        end
    end

    def visiting_ratio(url)
        #signature function

    end

    def caller
        h = diction()
        papers_generic_flag = true
        papers_generic_count = 0
        dr_to_ful = []
        faculty = []
        totalPhd = []
        totalFor = []
        research = []
        programs = []
        papers_arr1 = []
        papers_arr2 = []
        papers_arr3 = []
        journals = 0
        confer = 0
        books = 0
        junk2 = 0
        junk1 = 0

        criteria = params[:first]
        urls = params[:second]
        @criteriaOut = JSON.parse(criteria)
        @urlOut = JSON.parse(urls)
        absUrls = JSON.parse(urls)
        hasher = JSON.parse(response.body) rescue {}
        
        journalsArr = []
        confersArr = []
        booksArr = []
        junk = []
        totalFac = 0
        pphd = 0
        foriegn = 0
        j = 0
        i = 0
        uni_flag = true
        research_count = 0
        programs_count = 0
        puts "url length ",@urlOut.length   
        puts "Total url",absUrls
        puts "Criteria",@criteriaOut
        puts "criteria length ",@criteriaOut.length
        
        while (j < @urlOut.length)
            i=0
            absUrls[j] =  @urlOut[j]
            absUrl2 = absUrls[j]
            while (i < @criteriaOut.length )
                urls = params[:second]
                puts "Param",urls
                absUrls = JSON.parse(urls)
                puts "Param",absUrls
                absUrl2 = absUrls[j]
                absUrl = absUrl2
                puts "Param",absUrls
                if @criteriaOut[i]== 'fac'
                    #----------------changing the code here--------------------
                    begin
                        junk,totalFac,pphd = total_faculty(absUrl)
                    rescue
                        faculty.push("$") 
                        puts "hello"
                    else
                        puts "totalFac",totalFac
                        faculty.push(totalFac)
                    # fcount = foreign_phd_faculty(absUrl)
                    # faculty.push(fcount)
                    end
                elsif @criteriaOut[i]=='fphd'
                    puts "FPHD",absUrl
                    begin
                            
                        foriegn = foreign_phd_faculty(absUrl)
                    rescue
                        totalFor.push("$")
                    else 
                        totalFor.push(foriegn)
                    end
                elsif @criteriaOut[i]=='phd'
                begin
                    junk,totalFac,pphd = total_faculty(absUrl)
                rescue
                    totalPhd.push("$") 
                    puts "hello"
                else
                    if pphd == 0
                        urls = params[:second]
                        puts "Param",urls
                        absUrls = JSON.parse(urls)
                        puts "Param",absUrls
                        absUrl2 = absUrls[j]
                        absUrl = absUrl2
                        #puts "absUrl",absUrls
                        pphd = phd_faculty(absUrl)
                        totalPhd.push(pphd)
                        if pphd > totalFac
                            totalFac+=pphd
                        end
                        puts pphd
                    else
                        totalPhd.push(pphd)
                    end                 
                end
                elsif @criteriaOut[i] == 'rt_phd'
                    begin
                        dr,prof,ratio = dr_to_full(absUrl)
                    rescue
                        dr_to_ful.push("$")
                    else
                        dr_to_ful.push(dr)
                        dr_to_ful.push(prof)
                        dr_to_ful.push(ratio)
                    end
                elsif @criteriaOut[i] == 'rv_total'
                    begin
                        visiting_ratio(@urlOut[j])
                    rescue
                        
                    end
                elsif @criteriaOut[i] == 'rg'
                    begin
                        arr = []
                        arr,research_count = researcher(absUrl)
                    rescue
                        research.push("$")
                    else
                        research.push(arr)
                        research.push(research_count)
                    end
                elsif @criteriaOut[i] == 'po'
                    begin
                    junk,totalFac,pphd = total_faculty(absUrl)
                    rescue
                        programs.push("$")
                    else
                        programs.push(programs_count)
                    end
                elsif @criteriaOut[i] == 'tp'
                    begin
                        if papers_generic_flag == true
                            paper_arr = papers(absUrl,h)
                            papers_arr1 = paper_arr
                            papers_generic_flag = false
                            papers_generic_count+=1
                        end
                        #paper_arr = []
                        urls = params[:second]
                            puts "Param",urls
                            absUrls = JSON.parse(urls)
                            puts "Param",absUrls
                            absUrl2 = absUrls[j]
                            absUrl = absUrl2
                        if uni_flag == true    
                            uni_param = uni_name(absUrl)
                            uni_flag = false
                            puts uni_param
                        end
    
    
                        urls = params[:second]
                        puts "Param",urls
                        absUrls = JSON.parse(urls)
                        puts "Param",absUrls
                        absUrl2 = absUrls[j]
                        absUrl = absUrl2
                            
                        tech_arr,tech_arr_solo,tech_arr_total = ieee_function(absUrl,uni_param)
                        puts "************",tech_arr,tech_arr_solo,tech_arr_total
                        paperIndex = 0
                        totalJournals = 0
                        puts paper_arr.length
                        #puts "myfuckingarr",paper_arr
                        while paperIndex<paper_arr.length
                                 
                            if paper_arr[paperIndex].nil?
                                puts"ifnil #{paperIndex}"                             
                                paperIndex+=1
                            else
                                puts"else #{paperIndex}"
                                #puts paper_arr[paperIndex][:teachers_name]
                                #puts paper_arr[paperIndex][:journalss]
                                journalsArr.push(paper_arr[paperIndex][:teachers_name])
                                journalsArr.push(paper_arr[paperIndex][:journalss])
                                totalJournals+=paper_arr[paperIndex][:journalss]
                                paperIndex+=1
                            end
                        end
                        journalsArr.push(totalJournals)
                    rescue
                        journalsArr.push("$")
                    end
                    
                    #journalsArr.push(tech_arr)
                    #journalsArr.push(tech_arr_solo)
                    #journalsArr.push(tech_arr_total)
                    # papers_arr1.push(journals)
                    #papers_arr2.push(junk1)
                    #papers_arr3.push(junk2)
                elsif @criteriaOut[i] == 'cp'
                    begin
                        puts "papers_generic_flag",papers_generic_flag
                        puts "-------------paper_arr1",papers_arr1
                        # if papers_generic_flag == true
                        #     paper_arr = papers(absUrl)
                        #     papers_generic_flag = false
                        #     papers_arr1 = paper_arr
                        # end
                        if papers_generic_flag == true && papers_generic_count == 0
                            paper_arr = papers(absUrl,h)
                            papers_generic_flag = false
                            papers_arr1 = paper_arr
                        end
                        paperIndex = 0
                        totalJournals = 0
                        
                        while paperIndex<papers_arr1.length
    
    
                            if papers_arr1[paperIndex].nil?
                                paperIndex+=1
                            else
    
                                confersArr.push(papers_arr1[paperIndex][:teachers_name])
                                confersArr.push(papers_arr1[paperIndex][:confer_paperss])
                                #confersArr.push(paper_arr[paperIndex][:confer_paperss])
                                totalJournals+=papers_arr1[paperIndex][:confer_paperss]
                                paperIndex+=1
                            end
                        end
                        confersArr.push(totalJournals)
    
                    rescue
                        confersArr.push("$")
                    end
                    
                elsif @criteriaOut[i] == 'bp'
                    begin
                        puts "papers_generic_flag",papers_generic_flag
                        puts "-------------paper_arr1",papers_arr1
                        if papers_generic_flag == true && papers_generic_count == 0
                            paper_arr = papers(absUrl,h)
                            papers_arr1 = paper_arr
                            papers_generic_flag = false
                        end
                        paperIndex = 0
                        totalJournals = 0
    
    
                        
                        while paperIndex<papers_arr1.length
    
    
                            if papers_arr1[paperIndex].nil?
                                paperIndex+=1
                            else
                                booksArr.push(papers_arr1[paperIndex][:teachers_name])
                                booksArr.push(papers_arr1[paperIndex][:bookss])
                                #booksArr.push(paper_arr[paperIndex][:bookss])
                                totalJournals+=papers_arr1[paperIndex][:bookss]
                                paperIndex+=1
                            end
                        end
                        booksArr.push(totalJournals)
                    rescue
                        booksArr.push("$")
                    end
                    
                end

                i+=1
                uni_flag = true
            end
            j+=1
            papers_generic_flag = true
        end






        @faculty = faculty
        @dr = dr_to_ful
        @totalPhd = totalPhd
        @totalFor = totalFor
        @research = research
        @programs = programs
        @papers1 = journalsArr
        @papers2 = confersArr
        @papers3 = booksArr
        @details = junk
        @results = []
        @results.push(@faculty)
        @results.push(@totalPhd)
        @results.push(@totalFor)
        @results.push(@research)
        @results.push(@programs)
        @results.push(@papers1)
        @results.push(@dr)
        @results.push(@dr)
        @results.push(@papers3)
        @results.push(@papers2)
        @results.push(@details)
        render :json =>  @results.as_json()

    end
    end