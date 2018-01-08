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


def total_faculty(url)

	agent = Mechanize.new

	backup = url
	associate_professor=0
	assistant_professor=0
	teaching_fellow=0
	professor=0
	visiting_professor=0
	lecturer=0
	instructor=0
	lab_engineer=0
	phd_professor=0
	research_associate=0
	adjunct=0
	lums_fac = 0
	total_fac = 0
	professor_arr = []
	outer_prof = 0
	name_arr = []

	a = url
	puts "a: #{a}"
	html,my_body,my_page,my_check = facultyFinder(a)

	if html == 0
		return "N/A","N/A","N/A"
	end
	if status==0
		return "N/A","N/A","N/A"
	end
	
	#puts "html.title",html.title	
	counter = 0
	push_array = []
	html.traverse do |node|
		if node.text?
			if node.content.include? "Associate Professor"
				associate_professor+=1			
			end
			if node.content.include? "Assistant Professor"
				assistant_professor+=1
			end
			if node.content.include? "Teaching Fellow"
				teaching_fellow+=1
			end
			if node.content.include? "Professor"
				professor+=1
			end
			if node.content.include? "Visiting Professor"
				visiting_professor+=1
			end
			if node.content.include? "Lecturer"
				lecturer+=1
			end
			if node.content.include? "Instructor"
				instructor+=1
			end
			if node.content.include? "Lab Engineer"
				lab_engineer+=1
			end
			if node.content.include? "Research Associate"
				research_associate+=1
			end
			if node.content.include? "Dr."
				phd_professor+=1
				#puts node.content
			end
			if node.content.include? "Adjunct"
				adjunct+=1
				#puts node.content
			end
			if node.content.include? "Professor"
				#puts node.content
				outer_prof+=1				
				professor_arr.push(node.content)
				#puts node.parent.name
				if ((node.content.include? "Associate ") || 
					(node.content.include? "Assistant "))
					#puts node.content
					professor+=1
				end
			end
		end
	end



	new_arr = []
	total_fac+=associate_professor+assistant_professor+visiting_professor+phd_professor
					+lecturer+instructor+lab_engineer+research_associate

                    puts total_fac

    professor = outer_prof-(associate_professor+assistant_professor)

    new_arr.push(associate_professor)
    new_arr.push(assistant_professor)
    new_arr.push(visiting_professor)
    new_arr.push(lecturer)
    new_arr.push(instructor)
    new_arr.push(lab_engineer)
    new_arr.push(research_associate)
	new_arr.push(professor)


    puts "associate_professor",new_arr[0]
    puts "assistant_professor",new_arr[1]
    puts "visiting_professor",new_arr[2]
    puts "lecturer",new_arr[3]
    puts "instructor",new_arr[4]
    puts "lab_engineer",new_arr[5]
    puts "research_associate",new_arr[6]
    puts "Professor",new_arr[7]
    puts "phd_professor",phd_professor
    total_fac = 0
    total_fac+=new_arr[0]+new_arr[1]+new_arr[2]+new_arr[3]+new_arr[4]+new_arr[5]+new_arr[6]+new_arr[7]
    puts "totalfac",total_fac

    return new_arr,total_fac,phd_professor
end