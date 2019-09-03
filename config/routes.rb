Rails.application.routes.draw do
  get 'posts/new'

  get 'sessions/new'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'static_pages#home'
  resources :users
  resources :posts
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
