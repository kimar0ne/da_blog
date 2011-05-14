DaBlog::Application.routes.draw do
  
  resources :users

  match '/signup',  :to => 'users#new'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'  
  match '/signup',  :to => 'users#new'
  
  root :to => 'pages#home'
  
  get "pages/home"
  get "pages/contact"  
  get "pages/about"

  #resources :posts
  #resources :users

  
end
