require "resque/server"
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#index"
  mount Resque::Server.new, at: "/resque"
  get "/login", to: "auth#login", as: :login
  get "/auth", to: "auth#auth", as: :auth
  get "/fix_auth", to: "auth#fix_auth", as: :fix_auth
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/init", to: "dashboard#initialize_all", as: :initialize_all
  # get "/dashboard/search_groups", to: "dashboard#groups_list", as: :groups_list
  get "/logout", to: "auth#logout", as: :logout
  get "/load_stats", to: "stats#load_stats", as: :load_stats
  get "/load_posts", to: "posts#load_posts", as: :load_posts

  scope path: "themes", as: "themes" do
    controller "themes" do
      get "analyze_popular", to: "analyze_popular", as: :analyze_popular
      get "popular", to: "popular", as: :popular
      get "show_target_audience", to: "show_target_audience", as: :show_target_audience
      get "get_target_audience", to: "get_target_audience", as: :get_target_audience
    end
  end

  # get "/themes/analyze_popular", to: "themes#analyze_popular", as: :themes_analyze_popular
  # get "/themes/popular", to: "themes#popular", as: :themes_popular

  resources :groups, only: [:create, :show, :destroy, :update] do
    resources :stats, only: [:index]
    resources :themes
  end
end
