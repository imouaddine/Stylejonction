Stylejonction::Application.routes.draw do
 require 'subdomain' 
 
 devise_for :users
 
 match "/users" => "users#index"
  
 constraints(Subdomain) do
    match '/' => 'portfolios#show'

    resource :portfolio, :except => [:destroy, :new] do
      member do 
        get 'edit_layout'
        get 'edit_font'
        post 'upload_background'
        put 'publish'
      end
      resources :projects  do
        member do
         match 'upload_cover'
        end
      end
   end
 end
  
 #match "portfolio/:id" => "portfolios#show"
 match '#/:page' => 'pages#:page', :as => :page
 root :to => "pages#index"
end
