Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :statuses
end
