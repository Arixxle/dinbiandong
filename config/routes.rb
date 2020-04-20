Rails.application.routes.draw do
  resources :categories

  resources :items do
    resources :comments, only:[:create]
    # /new 不需要是因為，已經在show頁面有欄位，不需要一個獨立頁面
    # /create
  end

  # resources :comments
  #/:id
  #/:id


  # get "/", to: "welcome#index"
  root "items#index"
  get "/login", to: "users#login"
  post "/login", to: "users#signin"
  delete "/logout", to: "users#logout"

  get "/sign_up", to: "users#sign_up"
  post "/sign_up", to: "users#registration"
end
