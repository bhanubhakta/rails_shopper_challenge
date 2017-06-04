Rails.application.routes.draw do
  root "home#index"
  get "applicants/sign_up" => "applicants#new", as: :register
  get "applicants/login" => "sessions#new", as: :login
  post "applicants/login" => "sessions#create"
  post "applicants/logout" => "sessions#logout", as: :logout

  resources :applicants, only: [:new, :create, :update, :edit, :show] do
    collection do
      get :background
      post :authorize, path: "authorize"
      get :confirm
    end
  end
  
  resources :funnels, only: [:index]
end
