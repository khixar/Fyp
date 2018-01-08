require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'Mechanize'
$VERBOSE = nil
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG=nil
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
def matchIds(id1,id2)
    check =false
    if id1.length==id2.length
        i=0
        while (i<id1.length) && (!check)
            if id1[i]!=id2[i]
                check = true
            end
            i+=1
        end
        return i,1
    elsif id1.length<id2.length
        i=0
        while (i<id1.length) && (!check)
            if id1[i]!=id2[i]
                check = true
            end
            i+=1
        end
        return i,2
    else
        i=0
        while (i<id2.length) && (!check)
            if id1[i]!=id2[i]
                check = true
            end
            i+=1
        end
        return i,3
    end
end
def faculties(node)
    if (node != nil)
        node.traverse do |nextNode|
            if nextNode.text?
                if (nextNode.content.include? "Faculties") || (nextNode.content.include? "FACULTIES") || (nextNode.content.include?"ADMINISTRATION")
                    return 1
                end
            end
        end
    end
    return 0
end
def matchCloseLink(oriLink,idArray)
    if (oriLink.include? "id=") 
        id = oriLink[oriLink.index('id=')+3,oriLink.length-1]
    elsif (oriLink.include? "ID=") 
        id = oriLink[oriLink.index('ID=')+3,oriLink.length-1]
    end
    
    len = 0
    cri = 0
    i = 0
    prevLen = 0
    requiredLink = 0
    while i<idArray.length
        if (idArray[i].include? "id=")
            len,cri = matchIds(id, idArray[i][idArray[i].index('id=')+3,idArray[i].length-1])
        elsif (idArray[i].include? "ID=")
            len,cri = matchIds(id, idArray[i][idArray[i].index('ID=')+3,idArray[i].length-1])
        end
        if (cri == 1) && (len==id.length)
            requiredLink = i
            break
        elsif (cri == 1) && (len!=id.length) && (len>prevLen)
            requiredLink = i
            prevLen = len
        elsif ((cri == 3) || (cri == 2)) && (len>prevLen)
            requiredLink = i
            prevLen = len
        end
        i+=1
    end
    return idArray[i]
end
def checkUrl(url)
    begin
        html = Nokogiri::HTML(open(url))
    rescue Exception => msg
        return -1
    else
        html.traverse do |node|
            if node.text?
                if (node.content.include? "Asst. Prof.") 
                    return 1
                elsif (node.content.include? "Faculty") && (!node.content.include?"Attends the") && (!node.content.include?"SBASSE")
                    if (node.parent.name == "h1") || (node.parent.name == "h2")  || (node.parent.parent.name == "h1") || (node.parent.parent.name == "h2") || (node.parent.name == "strong") 
                        if (faculties(node.parent.previous_element) == 0) && (faculties(node.parent.parent.previous_element) == 0) && (faculties(node.parent.parent.parent.previous_element) == 0) && (faculties(node.parent.parent.parent.parent.previous_element) == 0) && (faculties(node.parent.parent.parent.parent.parent.previous_element) == 0) && (faculties(node.parent.parent.parent.parent.parent.parent.previous_element) == 0) && (faculties(node.parent.parent.parent.parent.parent.parent.parent.previous_element) == 0)
                            return 1
                        end
                    end
                end  
            end
        end
        return 0
    end
    
end
def facultyFinder(url)
    status = 1
    begin
        oriUrl = url.dup
        if (checkUrl(url) == 1)
            puts "Hello"
            agent = Mechanize.new
            page = agent.get oriUrl
            my_return = agent.get oriUrl
            puts "my_return",my_return.uri
            html = Nokogiri::HTML(open(oriUrl))
            check = my_return.uri
            page = agent.get check
            return html,my_return,page,check
        end
        html = Nokogiri::HTML(open(url))
    rescue Exception => msg
        status=0
        return "","","",""
    else
        check=0
        if (oriUrl.include?"uos.edu.pk")
            nodes = []
            html.traverse do |node|
                if (node.name.include?"ul") && (node.attributes['class']!=nil) 
                    nodes.push (node)
                end
            end
            fac = nodes[nodes.count-2].children[5].child.attributes['href']
            check += 1
        end
        
        
        check1 = ''
        body1 = ''
        faculty = ''
        fac = ''
        iid = 0
        id = ''
        if (url.include? "id=")  
            id = url[url.index('id='),url.length-1]
        elsif (url.include? "ID=")
            id = url[url.index('ID='),url.length-1].downcase
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
        end
        idArray = []
        check2 = 0
        if(check == 0)
            html.traverse do |node|
                if node.text?  
                    if (node.content.include? "People") || (node.content.include? "Faculty") 
                        fac = node.parent.attributes['href'].to_s
                        
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                        end
                        if ((fac.length>0) && (fac.include? id) && (id.length>0) && (fac[0]!='#')) 
                            check1 = fac
                            check+=1
                            idArray.push(fac)
                        end
                    end
                end
            end
        end
        if idArray.length>0
            fac = matchCloseLink(oriUrl,idArray)
            check1 = fac
            check+=1
        end
        if(check == 0)
            html.traverse do |node|
                if node.text?  
                    if ((node.content.include? "People") || (node.content.include? "Faculty") ) && (!node.content.include? "Handbook")
                        fac = node.parent.attributes['href'].to_s
                        if (node.content[0].include?"#") && (node.parent.next_element!= nil) && (node.parent.next_element.name == "ul")
                            node.parent.next_element.traverse do |node2|
                                if (node2.text?) && (node.content.include? "Profile")
                                    fac = node2.parent.attributes['href'].to_s
                                end
                            end
                        end
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                        end
                        if ((fac.length>0) && (fac.include? parts[parts.length-1])  && (fac[0]!='#')) 
                            check1 = fac
                            if (faculties(node.parent.previous_element) == 1) || (faculties(node.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.parent.previous_element) == 1)
                            else
                                if (fac.include? "hamdard.edu.pk")
                                    fac= node.parent.parent.parent.next_element.child.attributes['href']
                                end
                                check+=1
                                break
                            end
                        end
                    end
                end
            end
        end
        if(check == 0)
            html.traverse do |node|
                if node.text?  
                    if (node.content.include? "People") || (node.content.include? "Faculty") 
                        fac = node.parent.attributes['href'].to_s
                        if (node.content[0].include?"#") && (node.parent.next_element!= nil) && (node.parent.next_element.name == "ul")
                            node.parent.next_element.traverse do |node2|
                                if (node2.text?) && (node.content.include? "Profile")
                                    fac = node2.parent.attributes['href'].to_s
                                end
                            end
                        end
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                        end
                        if ((fac.length>0) && (fac.include? parts[parts.length-2]) && (fac[0]!='#')) 
                            check1 = fac
                            if (faculties(node.parent.previous_element) == 1) || (faculties(node.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.parent.previous_element) == 1)
                            else
                                check+=1
                                break
                            end
                        end
                    end
                end
            end
        end
        if (check == 0)
            html.traverse do |node|
            if node.text?  
                if (node.content.include? "People") || (node.content.include? "Faculty") 
                        fac = node.parent.attributes['href'].to_s
                        if (node.content[0].include?"#") && (node.parent.next_element!= nil) && (node.parent.next_element.name == "ul")
                            node.parent.next_element.traverse do |node2|
                                if (node2.text?) && (node.content.include? "Profile")
                                    fac = node2.parent.attributes['href'].to_s
                                end
                            end
                        end
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                        end
                        if ((fac.length>0) && ((fac.include? 'department')  || (fac.include? 'dept') || (fac.include? 'Department')  ) && (fac[0]!='#')) 
                            check1 = fac
                            if (faculties(node.parent.previous_element) == 1) || (faculties(node.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.parent.previous_element) == 1)
                            else
                                check+=1
                                break
                            end
                        end
                    end
                end
            end
        end
        if(check==0)
            html.traverse do |node|
                if node.text?  
                    if (node.content.include? "People") || (node.content.include? "Faculty") 
                        fac = node.parent.attributes['href'].to_s
                        if (node.content[0].include?"#") && (node.parent.next_element!= nil) && (node.parent.next_element.name == "ul")
                            node.parent.next_element.traverse do |node2|
                                if (node2.text?) && (node.content.include? "Profile")
                                    fac = node2.parent.attributes['href'].to_s
                                end
                            end
                        end
                        if(fac=='')
                            fac = node.parent.parent.attributes['href'].to_s
                            check1 = fac
                        end
                        if(fac=='')
                            fac = node.parent.parent.parent.attributes['href'].to_s
                            check1 = fac
                        end
                        if (!node.content.include? "Hostel") && (!node.content.include?"Internationalisation")
                            if (faculties(node.parent.previous_element) == 1) || (faculties(node.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.previous_element) == 1) || (faculties(node.parent.parent.parent.parent.parent.parent.parent.previous_element) == 1)
                            else
                                check+=1
                                
                                break
                            end	
                        end
                    end
                end
            end
        end

        puts "fac(((((((((((",fac

        agent = Mechanize.new
        page = agent.get oriUrl
        my_return = page.link_with(:href => fac).click
        puts "my_return",my_return.uri
        html = Nokogiri::HTML(open(my_return.uri))
        check = my_return.uri
        page = agent.get check
        return html,my_return,page,check
    end
end
