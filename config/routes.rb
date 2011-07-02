Stylejonction::Application.routes.draw do
 require 'subdomain' 
 
 devise_for :users
 
 match "/users" => "users#index"
 match '#/:page' => 'pages#:page', :as => :page
 match "portfolio/:id" => "pages#index"
  
 constraints(Subdomain) do
    match '/' => 'portfolio#show'

    resource :portfolio, :except => [:destroy, :new] do
      member do 
        get 'edit_layout'
        get 'edit_font'
      end
      resources :projects  do
        member do
         match 'upload_cover'
        end
      end
   end
 end
  
 root :to => "pages#index"
end
