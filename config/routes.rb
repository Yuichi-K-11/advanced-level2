Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  post 'create/:id' => 'relationships#create', as: 'create'     # フォローする
  post 'destroy/:id' => 'relationships#destroy', as: 'destroy'  # フォロー外す

  get 'user/follow/:id' => 'users#follow', as:'follow'
  get 'user/follower/:id' => 'users#follower', as:'follower'
end