Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#index"
  get "/login", to: "auth#login", as: :login
  get "/auth", to: "auth#auth", as: :auth
  get "/fix_auth", to: "auth#fix_auth", as: :fix_auth
  get "/dashboard", to: "dashboard#index", as: :dashboard
  # get "/dashboard/search_groups", to: "dashboard#groups_list", as: :groups_list
  get "/logout", to: "auth#logout", as: :logout
  get "/load_stats", to: "stats#load_stats", as: :load_stats
  get "/load_posts", to: "posts#load_posts", as: :load_posts

  resources :groups, only: [:create]
  resources :stats, only: [:index]
  resources :themes, only: [:new, :create, :index, :destroy]
end
