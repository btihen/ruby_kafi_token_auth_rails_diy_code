Rails.application.routes.draw do
  resources :users
  get  'login/new',  as: 'new_login',      to: 'sessions#new'
  post 'login',      as: 'login',          to: 'sessions#create'
  get 'auth/:token', as: 'session_auth',   to: 'sessions#auth'
  get 'logout',      as: 'session_delete', to: 'sessions#destroy'
  get 'landing',     as: 'landing',        to: 'landing#index'
  root to: "landing#index"
end
