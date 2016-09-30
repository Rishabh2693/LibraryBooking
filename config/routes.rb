Rails.application.routes.draw do


  get 'bookings/search'
  post 'bookings/search', to: 'bookings#search_post'
  get 'bookings/bookroom'
  get '/roomhistory/:id', to: 'bookings#roomhistory',  via: :get, as: :room_history
  get '/userhistory/:id', to: 'bookings#userhistory', via: :get, as: :user_history
  get '/index_admin', to: 'library_members#index_admin'
  get '/new_admin', to: 'library_members#new_admin'
  get '/new_admin_library_member', to: 'library_members#new_admin_library_member'
  post '/index_admin', to: 'library_members#create_admin'
  resources :bookings
  resources :rooms
  get 'sessions/new'
  #get 'library_members/new'
  resources :library_members
  get 'static_pages/home'
  get  '/signup',  to: 'library_members#new'
  get 'static_pages/help'
  get 'static_pages/about'
  root 'static_pages#home'
  post '/signup',  to: 'library_members#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
