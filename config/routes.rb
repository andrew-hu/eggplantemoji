Rails.application.routes.draw do
  resources :folders
  resources :assets
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root 'assets#index', as: :authenticated_root
  end
    root :to => "home#index"
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
