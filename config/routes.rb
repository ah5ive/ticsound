Rails.application.routes.draw do
  root "events#index"

  devise_for :users

  resources :users
  # resources :users

  resources :events
  post "/favourites/:id", to: "events#postfav", as: "post_fav"
  get "/favourites", to: "events#showfav", as: "show_fav"
  # destroy "/favourites/:id", to: "events#destroyfav", as: "destroy_fav"
  delete "/favourites/:id", to: "events#deletefav", as: "delete_fav"

  get "events/filter", to: "events#showfilter", as: "event_show_filter"

  post "events/filter", to: "events#filter", as: "event_filter"

  #ajax request
  get "/users-coordinates", to: "users#currloca", as: "user_currloc"
end