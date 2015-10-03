Rails.application.routes.draw do
  root "welcome#index"
  
  get "/lists", to: "lists#index"
end
