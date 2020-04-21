Rails.application.routes.draw do
  # routes由上往下判定，可以把常去的頁面放最上面
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

  #APIs 
  namespace :api do
    namespace :v1 do
      resources :items, only: [] do
        member do 
          post :favorite
        end
      end
    end
  end

end
