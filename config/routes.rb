Rails.application.routes.draw do
  resources :categories
  resources :items

  # get "/", to: "welcome#index"
  root "items#index"
  get "/login", to: "users#login"
  post "/login", to: "users#signin"
  delete "/logout", to: "users#logout"

  get "/sign_up", to: "users#sign_up"
  post "/sign_up", to: "users#registration"
end
