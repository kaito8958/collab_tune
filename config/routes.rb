Rails.application.routes.draw do
  get '/uptime', to: 'application#uptime'
  devise_for :users

  root "posts#index"

  resources :users, only: [:show] do
    member do
      get :posts   # /users/:id/posts
    end
  end

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
