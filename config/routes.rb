Rails.application.routes.draw do
  resources :users
  get 'landing',     as: 'landing',        to: 'landing#index'
  root to: "landing#index"
end
