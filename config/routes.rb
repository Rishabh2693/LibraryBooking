Rails.application.routes.draw do

  get '/roomhistory/:id', to: 'bookings#roomhistory',  via: :get, as: :room_history
  get '/userhistory/:id', to: 'bookings#userhistory', via: :get, as: :user_history
  resources :bookings
  resources :rooms
  get 'sessions/new'
  #get 'library_members/new'
  resources :library_members
  get 'static_pages/home'
  get  '/signup',  to: 'library_members#new'
  get 'static_pages/help'
  root 'static_pages#home'
  post '/signup',  to: 'library_members#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
