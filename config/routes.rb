Rails.application.routes.draw do
  devise_for :users

  resources :messages
  resources :subjects do
    resources :messages, only: [:create]
  end
  root 'subjects#index'
end
