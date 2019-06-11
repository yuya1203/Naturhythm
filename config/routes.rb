Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'microposts#index'

  get 'toppage', to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'rankings/favorite', to: 'rankings#favorite'
  get 'rankings/follower', to: 'rankings#follower'

  get 'tags/:tag', to: 'microposts#index', as: :tag

  get 'microposts/search', to: 'microposts#search'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
    # collection do
    #   get :search
    # end
  end
  resources :microposts, only: [:new, :show, :create, :destroy, :index] do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
end
