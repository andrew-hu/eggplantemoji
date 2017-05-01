Rails.application.routes.draw do
  resources :folders
  resources :assets




  #for creating folders insiide another folder
  match "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder" , :via => [:get, :post]

  #for uploading files to folders
  match "browse/:folder_id/new_file" => "assets#new", :as => "new_sub_file" , :via => [:get, :post]

  match "browse/:folder_id" => "home#browse", :as => "browse" , :via => [:get, :post]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
   # root 'assets#index', as: :authenticated_root <- this is causing our homepage disappearing
    root 'home#index', as: :authenticated_root
  end
    root :to => "home#index"
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
