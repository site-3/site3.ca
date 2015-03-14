Rails.application.routes.draw do
  devise_for :members

  root to: "static_pages#home"
end
