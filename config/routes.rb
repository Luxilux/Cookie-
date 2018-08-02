Rails.application.routes.draw do

root to:"user#home"
  get "/home", to:"user#home"
  get "/user", to:"user#user_id"
  get "/login", to:"sessions#new"
  post "/login", to:"sessions#create"
  delete "/login", to:"sessions#destroy"
  get "/logout", to:"sessions#destroy"
  delete "/logout", to:"sessions#destroy"



end
