class ApplicationController < ActionController::Base
  protect_from_forgery

  include UrlHelper

  def after_sign_in_path_for(resource)
    if params[:user].present?
      usr = User.find_by_email(params[:user][:email])
      redirect_url = request.url.gsub(/\/\//, "//#{usr.username}.").gsub(/www\./, "")
      return redirect_url.gsub(/users\/sign_in/, "portfolio/edit")
    else
      "/"
    end
  end  

  def after_sign_out_path_for(resource_or_scope)
    request.url.gsub(/\/\/(\w+)\./, "//").gsub(/users\/sign_out/, "")
  end


  protected 
  def get_portfolio
    @user = User.find_by_username!(request.subdomain)
    @portfolio = @user.portfolio
  end
end
