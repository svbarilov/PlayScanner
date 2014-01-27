require 'mail'
require 'csv'

#system("gem install mail")




#####   read email_to   #########################
email_to_array = CSV.read("email_source.csv") 
email_to_array.shift
email_to_array.uniq! {|mem| mem[0]}
#################################################

####   read email_from   #########################
your_email_array = CSV.read("your_email.csv")
your_email = your_email_array[0]

email_from = your_email[0].to_s 
password = your_email[1].to_s 
username = email_from.split("@").shift 
#################################################

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :user_name            => username,
            :password             => password,
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

 Mail.defaults do
  delivery_method :smtp, options
 end

#################################################




#################################################

email_to_array.each do |email|


#########   email text and subject   ###########
################################################
  
  email_subject = "Get your App to the Top Charts - pay upon results. Google Play, Amazon, App Store"

  email_text = "Hello#{email[2]} Team!

 < ext goes here >
 
   my_name  "
  
  email_from = "Dan Tj"
################################################
################################################
  
    
begin
mail = Mail.deliver do
   to       email[0]
   from     email_from
   subject  email_subject
   body     email_text
sleep 180
end

rescue
  sleep 180
  redo
end

end # end email_array block


