ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "ecomstrategy.ca",  
  :user_name            => "stylejonction@ecomstrategy.ca",  
  :password             => "stylejonction",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}