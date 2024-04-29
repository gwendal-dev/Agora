Rails.application.routes.draw do
  devise_for :users

  root 'subjects#index'

  resources :subjects do
    resources :messages do
      member do
        get 'reply', to: 'messages#reply'  # Ajoutez cette ligne ici
      end
    end
  end
end
