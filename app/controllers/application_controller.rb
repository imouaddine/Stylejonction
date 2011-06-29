class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include UrlHelper
  
  protected 
     def get_portfolio
       @user = User.find_by_username!(request.subdomain)
       @portfolio = @user.portfolio
     end
end
