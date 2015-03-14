Rails.application.routes.draw do
  devise_for :members, controllers: {
    registrations: 'members/registrations'
  }

  root to: "static_pages#home"
end
