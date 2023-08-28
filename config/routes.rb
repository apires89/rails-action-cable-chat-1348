Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :chatrooms, only: :show do
    #we need the chatroom_id to create a message
    #chatrooms/:chatroom_id/messages
    resources :messages, only: :create
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
