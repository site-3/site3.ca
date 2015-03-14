Rails.application.routes.draw do
  devise_for :members, controllers: {
    registrations: 'members/registrations'
  }

  resources :purchases

  root to: "static_pages#home"
end
