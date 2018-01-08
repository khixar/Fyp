require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'net/http'
require 'mechanize'
$VERBOSE = nil
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
def common2(url)
    fac = ""
    a= url.dup
    
    urls = ["https://lahore.comsats.edu.pk/cs/".strip,"https://lahore.comsats.edu.pk/ee/".strip,"https://www.bahria.edu.pk/buic/ee/".strip,"https://www.bahria.edu.pk/buic/cs/".strip,"http://www.au.edu.pk/dept_electrical_eng_intro.aspx".strip,"http://www.au.edu.pk/dept_comp_science_about.aspx".strip,"https://www.kiu.edu.pk/department/department-of-computer-sciences".strip,"http://uet.edu.pk/faculties/facultiesinfo/department?RID=introduction&id=9".strip,"http://uet.edu.pk/faculties/facultiesinfo/department?RID=introduction&id=8".strip,"http://pu.edu.pk/home/subdepartment/67003".strip,"http://pu.edu.pk/home/department/58/Punjab-University-College-of-Information-Technology".strip,"http://www.bzu.edu.pk/v2_department.php?cid=48".strip,"http://www.bzu.edu.pk/v2_department.php?cid=4".strip,"http://www.iub.edu.pk/department.php?id=14".strip,"http://www.iub.edu.pk/department.php?id=1".strip,"http://web.uettaxila.edu.pk/uet/EED/index.asp".strip,"http://web.uettaxila.edu.pk/uet/CS/index.asp".strip,"https://uos.edu.pk/department/profile/56".strip,"https://uos.edu.pk/department/profile/2".strip,"http://usindh.edu.pk/academics/faculties-uos/education/".strip,"http://usindh.edu.pk/academics/faculties-uos/natural-sciences/".strip,"http://www.muet.edu.pk/departments/electrical-engineering".strip,"http://www.muet.edu.pk/departments/software-engineering".strip,"http://www.salu.edu.pk/department/computer-science".strip,"http://www.quest.edu.pk/departments/bscs_intro.php".strip,"http://www.quest.edu.pk/departments/el_intro.php".strip,"http://www.sbbu.edu.pk/departments/cs/index.php".strip,"http://www.sbbusba.edu.pk/pages/It_intro.html".strip,"http://ee.uol.edu.pk/".strip,"http://cs.uol.edu.pk/".strip,"http://www.lcwu.edu.pk/index.php/faculties-institutes-17-new/engineering-technology-17-new/cs-17-new.html".strip,"http://www.lcwu.edu.pk/index.php/faculties-institutes-17-new/engineering-technology-17-new/dee-17-new.html".strip,"http://www.suit.edu.pk/department-info/9".strip,"http://www.suit.edu.pk/department-info/5".strip,"http://www.nu.edu.pk/Campus/Lahore".strip,"http://peshawar.abasyn.edu.pk/department.php?depart=3".strip,"http://peshawar.abasyn.edu.pk/department.php?depart=1".strip,"http://www.hamdard.edu.pk/fest/".strip,"https://sen.umt.edu.pk/ElectricalEngineering1/Home.aspx".strip,"https://sst.umt.edu.pk/cs/home.aspx".strip,"https://www.riphah.edu.pk/faculty/ict-electrical-engineering".strip,"https://www.riphah.edu.pk/faculty/ict-computing".strip,"http://www.hup.edu.pk/faculty-school-of-engineering/".strip,"http://www.hup.edu.pk/faculty-school-of-computer-science/".strip,"https://sbasse.lums.edu.pk/department/electrical-engineering".strip,"https://sbasse.lums.edu.pk/department/computer-science".strip,"http://cs.qau.edu.pk/".strip,"http://ele.qau.edu.pk/".strip,"http://www.iiu.edu.pk/?page_id=2078".strip,"http://www.iiu.edu.pk/?page_id=1811".strip,"http://www.uok.edu.pk/faculties/computerscience/index.php".strip,"http://csit.uom.edu.pk/".strip,"https://www.ucp.edu.pk/faculty-of-engineering/department-electrical-engineering/".strip,"https://www.ucp.edu.pk/faculty-of-information-technology/".strip,"http://uow.edu.pk/Programs/Computer.aspx".strip,"http://uow.edu.pk/BET/Default.aspx".strip,"http://www.buitms.edu.pk/Faculties/FICT/elec.aspx".strip,"http://www.buitms.edu.pk/Faculties/FICT/cs.aspx".strip,"http://www.fccollege.edu.pk/department-of-computer-science/".strip,"http://www.pieas.edu.pk/dcis/".strip,"http://www.pieas.edu.pk/dee/".strip,"https://www.giki.edu.pk/Faculties/FCSEUndergraduate".strip,"https://www.giki.edu.pk/Faculties/FEEUndergraduate".strip]
    href = ["ResearchGroups.aspx".strip,"ResearchGroups.aspx".strip,"#".strip,"https://www.bahria.edu.pk/buic/cs/research-areas/".strip,"https://sites.google.com/view/auee/home".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"info.asp".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"/research/research-groups".strip,"/research/research-groups".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"/research".strip,"/research".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"/department/electrical-engineering/groups".strip,"/department/computer-science/groups".strip,"research.php".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"#researchgroups_section".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip,"NULL".strip]
    
    flag = true
    index = 0
    while index<urls.count
        if urls[index].include?url
            flag = false
            break
        end
        index+=1
    end
    if !flag
        return href[index]
    end    
    begin
        html = Nokogiri::HTML(open(url))

    rescue Exception=>msg 
        puts msg
    else
        flag = false
        html.traverse do |node|
            if node.text?  
                if (node.content.include? "Group") 
                    fac = node.parent.attributes['href'].to_s
                    if(fac=='')
                        fac = node.parent.parent.attributes['href'].to_s
                    end
                    if(fac=='')
                        fac = node.parent.parent.parent.attributes['href'].to_s
                    end
                    if ((fac.length>0) && (fac[0]!='#') ) 
                        
                        
                        flag = true
                        break
                    end
                end
            end
        end
        if (!flag)
            html.traverse do |node|
                if node.text?  
                    if (node.content.include? "Research") 
                        fac = node.parent.attributes['href'].to_s
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                        end
                        if ((fac.length>0)  && (fac[0]!='#') ) 
                            if (node.parent.next_element!=nil) && (node.parent.next_element.name=="ul") 
                                
                            else 
                                
                            end
                            
                            flag = true
                            break
                        end
                    end
                end
            end
        end
    end


    
    return fac

end


def researcher(url)
    agent = Mechanize.new
    page = agent.get url
    fac = common2(url)
    begin
        html = page.link_with(:href => fac).click    
    rescue Exception => e
        return "#"
    else
    
        puts html
        html1 = Nokogiri::HTML(open(html.uri))
        puts html1.title
        
        r_counter = 0
        arr=[]

        html1.traverse do |node|
            if node.text?
                if node.content.include? "Research Center"
                    # puts node.content
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                    
                elsif node.content.include? "Natural Language Processing"
                    # puts node.content
                   
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Intelligence"
                    # puts node.content
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Robotics"
                    # puts node.content
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Data Mining"
                    # puts node.content
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Group"
                    # puts node.content
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Machine Learning"
                    # puts node.content
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Lab"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Processing"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Wireless Communincation"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Electronics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Energy"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Power"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Information Retrieval"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Computer Networks"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Human Computer Interaction"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Algorithms"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Recycling"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Web Semantics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Technologies"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Materials"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Environmental"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Polymer"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Systems"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Architectural"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Building"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Urban"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Design"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Structural"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Irrigation"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Process"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Pollution"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Structures"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Soil"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Renewable"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Earthquake"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Fluid"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Hazard"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end          
                elsif node.content.include? "Mechanics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end          
                elsif node.content.include? "Control"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end      
                elsif node.content.include? "Monitoring"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Risk"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Simulation"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end          
                elsif node.content.include? "Sustainable"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end              
                elsif node.content.include? "Aerodynamics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end              
                elsif node.content.include? "Combustion"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end          
                elsif node.content.include? "Manufacturing"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Dynamics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end      
                elsif node.content.include? "Acoustics"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end
                elsif node.content.include? "Vibrations"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end      
                elsif node.content.include? "Networks"
                    
                    if node.content.length <= 30
                        arr.push(node.content)
                        r_counter+=1
                    end                          
                end             
            end
        end
    end
    arr=arr.uniq
    # arr=arr-Research Groups
    puts arr
    return arr,arr.count

end

# url = "https://sbasse.lums.edu.pk/department/computer-science"
# a,b = researcher(url)
# puts a,b