Rails.application.routes.draw do
  get 'messages/create'
  get 'chat_rooms/index'
  get 'chat_rooms/show'
  get 'chat_rooms/create'
  devise_for :users
  root "posts#index"  
  resources :users, only: [:show]

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :collaborations, only: [:create, :index, :update]

  resources :chat_rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  # ✅ ここを追加（既読API）
  resources :messages, only: [] do
    patch :mark_as_read, on: :member
  end

  mount ActionCable.server => '/cable'
end
