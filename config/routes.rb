Stylejonction::Application.routes.draw do
 require 'subdomain'

 devise_for :users

  match "/users" => "users#index"

 constraints(Subdomain) do
    match '/' => 'portfolios#edit_layout'

    resource :portfolio, :except => [:destroy, :new] do
      member do
        get 'edit_layout'
        get 'edit_font'
        post 'upload_background'
        put 'publish'
      end
      resources :projects  do
        member do
         post 'invite'
         match 'upload_cover'
        end
      end
      resource :background, :except => [:destroy, :new, :create] do
        member do
           match 'upload'
        end
      end
   end
  end

  resources :invitations, :only => [:show]
  resources :fonts, :only => [:show]
  

 #match "portfolio/:id" => "portfolios#show"
 match '#/:page' => 'pages#:page', :as => :page
 root :to => "pages#index"
end
