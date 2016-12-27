Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#loginpage'
  resources :fusions
  resources :users
  resources :visitors
  get "/secure", to: "sessions#loginpage"
  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"
  get "/dashboard", to: "sessions#index"
  post "/searchvisitor", to: "visitors#searchvisitor"
end