Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "callbacks" }
  root 'dashboard#index'
end
