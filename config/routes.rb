Rails.application.routes.draw do
  root "welcome#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :users, path: ":user", as: :user do
    resources :lists, only: [:index, :show, :new, :create, :update] do
      member do
        patch "archived"
        patch "unarchived"
      end
    end
      get "/archived_lists", to: "archive#index"
  end

end

