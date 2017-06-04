Rails.application.routes.draw do
  root "home#index"
  get "applicants/sign_up" => "applicants#new", as: :register
  resources :applicants, only: [:create, :update, :show, :new]
  resources :funnels, only: [:index]
end
