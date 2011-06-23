DaBlog::Application.routes.draw do

  get "sessions/new"

  resources :blogposts
  resources :categories
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/signup', :to => 'users#new'
  match '/tags/:categories', :to => 'blogposts#tags'
  match '/blogposts', :to => 'blogposts#index'
  match '/categories', :to => 'categories#index'


  root :to => 'pages#home'

  get "pages/home"
  get "pages/contact"
  get "pages/about"


end
