emails = []

process_pages = 15


start = 0
while(start < process_pages * 60) 

	new_apps = `curl "https://play.google.com/store/apps/collection/topselling_new_free?start=#{start}" 2>/dev/null`

	app_urls = new_apps.scan(/href="(\/store\/apps\/details.+?)"/).map{|uri| "https://play.google.com#{uri}"}

	app_urls.uniq.each do |app_url|
		app_page = `curl #{app_url} 2>/dev/null`

		title = app_page.scan(/document-title.+?>.+?<div>([^<]+)/).flatten

		#developer = app_page.scan(/document-subtitle primary.+?apps\/developer\?id=.+?>([^<]+)/).flatten  # old code

    developer = app_page.scan(/document-subtitle primary.+?store\/apps\/developer\?id=([^<]+)/).flatten.to_s.to_s.gsub("+", " ").chop.chop.chop # new code
    #developer = developer.to_s.chop.chop.chop

		curr_emails = app_page.scan(/class="dev-link" href="mailto:(.+?)"/).flatten
		curr_emails.uniq.each do |email|
			puts %Q{"#{email}", "#{title}", "#{developer}"}
			emails << email
		end

	end

	# p emails

	start += 60
end