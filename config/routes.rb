Rails.application.routes.draw do
  devise_for :members, controllers: {
    registrations: 'members/registrations',
    sessions: 'members/sessions',
  }

  resources :purchases
  resources :member_applications, path: 'apply', only: [:new, :create]

  # Static pages
  get 'about' => 'static_pages#about'
  get 'membership' => 'static_pages#membership'
  get 'classes' => 'static_pages#classes'
  get 'projects' => 'static_pages#projects'
  get 'location' => 'static_pages#location'
  root to: "static_pages#home"
end
