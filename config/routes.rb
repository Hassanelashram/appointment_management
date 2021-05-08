Rails.application.routes.draw do
  devise_for :users

  resources :dentists, only: %i[index show] do
    resources :appointments, only: %i[create index show]
  end
  root to: 'pages#home'
end
