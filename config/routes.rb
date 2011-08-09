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
        put 'publish'
      end
      resources :projects, :except => [:index]  do
        member do
          post 'invite'
        end
      end
    end
  end
  
  resources :custom_backgrounds, :only => [:edit, :update, :create] do
     member do
       post 'upload'
       get 'remove_upload'
     end
  end
  resources :predefined_backgrounds, :only => [:show]
  resources :patterns, :only => [:show]
  resources :invitations, :only => [:show]
  resources :fonts, :only => [:show]
  resources :images do
    member do
      post 'upload'
      match 'crop'
    end
  end
  resources :text_blocks, :except => [:index]
  resources :galleries, :except => [:index] do 
    resources :videos
    resources :photos do 
      collection do
        post "upload" 
      end
    end
  end
  resources :document_blocks, :except => [:index] do 
    resources :documents
  end
  
  
  # This duplicates upload_image but doesn't need id
  match "/images/upload" => 'images#upload', :via => "post"

  #match "portfolio/:id" => "portfolios#show"
  match '#/:page' => 'pages#:page', :as => :page
  root :to => "pages#index"
end
