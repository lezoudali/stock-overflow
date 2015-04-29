Rails.application.routes.draw do
  # get  '/chatroom' => 'chats#room', :as => :chat

  get 'users/show'

  get 'users/update'

  get 'users/edit'

  post 'favorites/update'
  post 'favorites/price_history'
  post 'favorites/quote_data'

  devise_for :users, controllers: {omniauth_callbacks: "callbacks" }
  root 'dashboard#index'

  resources :users, only: [:edit, :update, :show]

  resources :stocks, only: [:index, :update]
  get 'stocks/:symbol', to: "stocks#show"
  get 'stocks/:symbol/series_data', to: "stocks#series_data"

  resources :forum_threads do 
    resources :forum_posts, module: :forum_threads
  end

  resources :messages, only: [:create]

  get '/search/query'

end
