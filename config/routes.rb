Rails.application.routes.draw do
  devise_for :users
  root "rooms#index"
  resources :room_messages
  resources :rooms
end
