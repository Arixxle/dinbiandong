Rails.application.routes.draw do
  # get "/", to: "welcome#index"
  root "welcome#index"
  get "/login", to: "users#login"
  get "/sign_up", to: "users#sign_up"
  post "/sign_up", to: "users#registration"
end
