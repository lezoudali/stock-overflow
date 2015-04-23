Rails.application.routes.draw do
  get 'users/show'

  get 'users/update'

  get 'users/edit'

  devise_for :users, controllers: {omniauth_callbacks: "callbacks" }
  root 'dashboard#index'

  resources :users, only: [:edit, :update, :show]

  resources :stocks, only: [:index, :update]
  get 'stocks/:symbol', to: "stocks#show"

  resources :forum_threads do 
    resources :forum_posts, module: :forum_threads
  end

end
