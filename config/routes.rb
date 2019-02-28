Rails.application.routes.draw do
  resources :blogs
  root 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#top"
  get "about" => "home#about"

  get "posts/allof" => "posts#allof"
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  post "posts/:id/destory" => "posts#destroy"

  get "answers/allof" => "answers#allof"
  get "answers/index" => "answers#index"
  get "answers/:id" => "answers#new"
  post "answers/:id/create" => "answers#create"

  post "update" => "users#update"
  get "edit" => "users#edit"
  get "users/allof" => "users#allof"
  get "signup" => "users#new"
  post "create" =>  "users#create"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "follower" => "users#index"
  get ":id" => "users#show"
end
