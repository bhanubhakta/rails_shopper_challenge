Rails.application.routes.draw do
  root "home#index"
  get "applicants/sign_up" => "applicants#new", as: :register
  get "applicants/login" => "sessions#new", as: :login
  post "applicants/login" => "sessions#create"
  post "applicants/logout" => "sessions#logout", as: :logout
  resources :applicants, only: [:create, :update, :show, :new]
  resources :funnels, only: [:index]
end
