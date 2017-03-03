Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "auth#login",  as: :login
  get "/auth", to: "auth#auth", as: :auth
  get "/fix_auth", to: "auth#fix_auth", as: :fix_auth
  get "/dashboard", to: "dashboard#index", as: :dashboard
  get "/dashboard/search_groups", to: "dashboard#groups_list", as: :groups_list
  get "/exit", to: "auth#exit", as: :exit 
end
