Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "users#index"

  get "/users" => "users#index", as: :users
  get "/users/new" => "users#new", as: :new_user
  post "/users" => "users#create"
  get "/users/:id" => "users#show", as: :user

  get "/chats" => "chats#index", as: :chats
  get "/chats/new" => "chats#new", as: :new_chat
  post "/chats" => "chats#create"
  get "/chats/:id" => "chats#show", as: :chat

  get "/messages" => "messages#index", as: :messages
  get "/messages/new" => "messages#new", as: :new_message
  post "/messages" => "messages#create"
  get "/messages/:id" => "messages#show", as: :message
end
