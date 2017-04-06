Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :members, controllers: {
    registrations: 'members/registrations',
    sessions: 'members/sessions',
    omniauth_callbacks: 'members/omniauth_callbacks',
  }

  resources :charges
  resources :cards, only: [:create]

  resources :member_applications, path: 'apply', only: [:new, :create]

  namespace :admin do
    resources :member_applications, path: 'member-applications', only: [:index] do
      post 'approve'
    end
  end

  resources :doorbot_members, only: [:index]

  # Static pages
  get 'about' => 'static_pages#about'
  get 'membership' => 'static_pages#membership'
  get 'classes' => 'static_pages#classes'
  get 'projects' => 'static_pages#projects'
  get 'location' => 'static_pages#location'
  root to: "static_pages#home"
end
