Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get '404', to: 'errors#show', via: :all
  get '500', to: 'errors#show', via: :all

  get 'homepage/index'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    resources :posts
  end

  get 'conversation/:id', to: 'conversations#show'
  post 'message', to: 'messages#create'

  resources :posts

  root 'homepage#index'
end
