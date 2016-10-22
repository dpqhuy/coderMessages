Rails.application.routes.draw do

  resources :sessions
  resources :users
  resources :friendships
  resources :messages

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'messages_sent' => 'messages#sent' 

  root 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
