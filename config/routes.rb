Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "meetings#index"

  resources :meetings, except: [:destroy] do
    member do
      patch :cancel
    end
    resources :requests, only: [:create]
    resources :messages, only: [:create]
    collection do
      get :historique, to: 'meetings#history'
    end
  end

  get 'meetings/:id/messages', to: 'meetings#messages', as: "meeting_message"
  resources :requests do
    member do
      patch :cancel
      patch :accept
      patch :reject
    end
  end

  resources :games, only: [:create]
  get 'conversations', to: 'meetings#conversations', as: "conversations"
  get 'my-meetings', to: 'meetings#my_meetings', as: "my-meetings"

end
