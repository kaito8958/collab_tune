Rails.application.routes.draw do
  get 'users/show'
  get 'messages/create'
  get 'chat_rooms/index'
  get 'chat_rooms/show'
  get 'chat_rooms/create'
  devise_for :users
  resources :users, only: [:show] do
    member do
      get :posts   # ← 追加（/users/:id/posts）
    end
  end

  root "posts#index"  

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :collaborations, only: [:create, :index, :update]

  resources :chat_rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :messages, only: [] do
    patch :mark_as_read, on: :member
  end

  mount ActionCable.server => '/cable'
end
