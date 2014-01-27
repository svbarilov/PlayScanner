require 'nokogiri'
require 'open-uri'



process_pages = 15


start = 0
while(start < process_pages * 60) 

# get "New Apps" HTML string
new_apps = Nokogiri::HTML(open('https://play.google.com/store/apps/collection/topselling_new_free?start=0')).to_s

# get array of app urls
app_urls = new_apps.scan(/href="(\/store\/apps\/details.+?)"/).map{|uri| "https://play.google.com#{uri.to_s.reverse.chop.chop.reverse.chop.chop}"}


# looping through every app url
app_urls.uniq.each do |app_url|
	 app_page = Nokogiri::HTML(open("#{app_url}")).to_s
   
   title = app_page.scan(/document-title.+?>.+?<div>([^<]+)/).flatten.to_s
   title = title.reverse.chop.chop.reverse.chop.chop
   
   developer = app_page.scan(/document-subtitle primary.+?store\/apps\/developer\?id=([^<]+)/).flatten.to_s.to_s.gsub("+", " ").chop.chop.chop
   developer = developer.reverse.chop.chop.reverse.chop.chop.chop
   
   curr_emails = app_page.scan(/class="dev-link" href="mailto:(.+?)"/).flatten.uniq.to_s
   email = curr_emails.reverse.chop.chop.reverse.chop.chop
   
    
   puts %Q{"#{email}", "#{title}", "#{developer}"}
 end

end   # end while
   





