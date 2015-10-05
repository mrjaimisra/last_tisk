Rails.application.routes.draw do
  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  namespace :users, path: ":user", as: :user do
    resources :lists, only: [:index, :new, :create, :show, :update] do
      member do
        patch "archived"
        patch "unarchived"
      end
    end
      get "/archived_lists", to: "archive#index"
  end

end

