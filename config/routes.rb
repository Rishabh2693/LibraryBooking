Rails.application.routes.draw do

  #get 'library_member/new'

  get 'static_pages/home'
  get  '/signup',  to: 'library_member#new'
  get 'static_pages/help'
  root 'static_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
