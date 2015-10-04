Rails.application.routes.draw do
  root "welcome#index"

  resources :lists, only: [ :index, :show, :new, :create, :update ] do
    member do
      patch "archived"
      patch "unarchived"
    end
  end

  get "/archived_lists", to: "archive#index"
end

