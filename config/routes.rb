Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "auth#login"
  get "/auth", to: "auth#auth", as: :auth
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/dashboard/search_groups", to: "dashboard#groups_list", as: :groups_list
end
