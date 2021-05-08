Rails.application.routes.draw do
  devise_for :users

  resources :dentists, only: %i[index show] do
    resources :appointments, only: %i[create show new]
  end
  resources :appointments, only: :index
  root to: 'dentists#index'
end
