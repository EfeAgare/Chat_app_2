# frozen_string_literal: true

Rails.application.routes.draw do
  root 'chatroom#index'
  get '/login' => 'sessions#new'
  post '/signup' => 'sessions#sign_up'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#delete'

  post '/message' => 'messages#create'
  post '/specific_message' => 'messages#specific_message_create'

  get '/user/:friend_message_id' => 'chatroom#chat_a_friend'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server, at: '/cable'
end
