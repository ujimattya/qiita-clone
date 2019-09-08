Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/destroy'

  get 'posts/new'

  get 'sessions/new'
  post '/users/:id/likes', to: 'users#likes'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/stocks', to: 'posts#stocks'
  root 'posts#index'
  resources :users 
  resources :posts
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
