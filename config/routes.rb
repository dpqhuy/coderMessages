Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  resources :users

  root 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end