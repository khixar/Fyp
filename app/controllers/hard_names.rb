require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'openssl'
require 'net/http'
require 'cobravsmongoose'
require 'pp'
require 'HTTParty'
require 'mechanize'

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




def dict(h,fin)
	if h[fin] != nil
		return 1
	end
	return 0
	
end



def teacher_name1(url,h)

# teacher_name = ''
# agent = Mechanize.new
# page = agent.get url
html = Nokogiri::HTML(open(url))
names = ["Ali","Syed","Onaiza","Abbas","Faiza","Sobia","Sidra","Shuaib","Fareed","Tabassum", "Abid","Shafay", "Abrar", "Adam", "Adeel","Ihsan","Muhammad","Humaira","Khan", "Adil","Afzal", "Afzaal", "Ahmed", "Ahmer", "Ahsan", "Ajmal", "Akbar", "Akhtar", "Akhter", "Akif", "Akram","Aqeel","Aqib","Aleem","Altaf","Amin","Amir","Amjad","Anwar","Aon","Arif","Arsalan","Arshad","Asad","Asim","Aslam","Ayaaz","Ayub","Azeem","Azhar","Aziz","Babar","Badar","Bashir","Basit","Danial","Danish","Dawood","Ehtisham","Fahad","Faiz","Farid","Farooq","Ghazanfar","Farrukh","Fawad","Fayaz","Fazal","Ghafoor","Ghayoor","Ghous","Hasan","Hussain","Habib","Hafeez","Haider","Hamid", "Hameed", "Haroon", "Harris", "Humayun","Ibrahim", "Idrees", "Iftikhar", "Ijaz", "Ilyas", "Imran", "Inzamam", "Iqbal", "Irfan", "Ishaq", "Ismail","Jabbar", "Jafar", "Jalal", "Jaleel", "Jamal", "Jameel", "Junaid", "Javid", "Jawad","Kabir", "Kaleem", "Karim", "Kareem", "Khalid", "Khurshid", "Khushal","Latif", "Lateef", "Mohammad", "Mohammed", "Mahmood", "Majid", "Maqsood", "Masood", "Mehr", "Mohsin", "Mubashar", "Mudassar", "Mujtaba", "Mumtaz", "Munawar", "Murtaza", "Musharraf", "Mushtaq", "Mustafa", "Mustansar", "Muzaffar","Nabeel", "Nadeem", "Naeem", "Nafees", "Najib", "Nasir", "Naseer", "Nauman", "Naveed", "Nawaz","Obaid", "Omar","Pervaiz","Parvez","Qadir", "Qais", "Qaiser", "Qasim", "Quddus","Raza", "Raees", "Rahim", "Rahman", "Rehman", "Rameez", "Rashid", "Rasheed", "Rauf", "Razzak", "Razzaq", "Riaz", "Rizwan","Saad", "Saadat", "Sabir", "Sadaqat", "Sadiq", "Saeed", "Safdar", "Safeer", "Saghar", "Sagheer", "Sahir", "Saif", "Sajid", "Sajjad", "Saqib", "Salahuddin", "Salim", "Salman", "Sarfraz", "Sarmad", "Sarwar", "Sattar", "Saqlain", "Saud", "Shabbir", "Shafqat", "Shafiq", "Shahbaz", "Shahid", "Shahzad", "Shakeel", "Shakir", "Shakoor", "Shamsher", "Shams", "Shan", "Sharjeel", "Shaukat", "Sheharyar", "Sher", "Sheraz", "Shoaib", "Shuja", "Shujaat", "Sibtain", "Siddiq", "Sikandar", "alexander", "Sohaib", "Sohail", "Sohrab", "Suleman", "Sultan","Tabraiz", "Taha", "Tahir", "Taimur", "Taj", "Tajammul", "Talat", "Tanweer", "Tanvir", "Tariq", "Taufeeq", "Taufiq", "Tauqeer", "Tauqir", "Tauseef", "Tehsin", "Tufail","Umair", "Umar", "Usman", "Uzair","Vakeel", "Vazir","Waheed", "Waheed", "Wahid", "Wajid", "Wakeel", "Wali", "Waqar", "Wasi", "Wasif", "Wasim", "Wazir","Yahya", "Yar", "Yasin", "Yasir", "Yawar", "Younas", "Younis", "Yousaf", "Yousuf","Zaeem", "Zafar", "Zaheer","Ghulam", "Rasool" ,"Zahid", "Zahoor", "Zaighum", "Zain", "Zakaria", "Zakir", "Zaman", "Zameer", "Zarar", "Zareef", "Zeeshan", "Zia", "Zohaib", "Zohair", "Zubair", "Zulfiqar", "Zulqarnain"] 

name_length = names.count
flag = true
iter = 0
puts html.title

get_name = ''

	html.traverse do |node|
		if node.text?
			flag = true
			iter = 0
			while iter < names.count
				
				if node.content.include? names[iter]
					#puts node.content
					get_name = node.content

					get_name = get_name.split(' ')
					


					i = 0
					arr = []
					while (i < get_name.length)
						res = dict(h,get_name[i].downcase)
						# check if this name is in the 
						arr.push(res)
						i+=1
					end



					i = 0
					while i < arr.length
						if arr[i] == 1
							flag = false
							break
						else
							i+=1
						end
					end

					if flag
						puts get_name
						return get_name
					else
						break
					end

					# puts names[iter]
					# flag = false
					# break					
				end
				iter+=1
			end
			# if !flag
			# 	break
			# end
		end
	end

end 


