Rails.application.routes.draw do
  devise_for :users
  resources :subjects do
    resources :messages
  end
  root 'subjects#index'
end
