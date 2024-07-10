Rails.application.routes.draw do
  resources :categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products do
    resource :buy_now, only: [:show, :create], controller: :buy_now do
      get "success", on: :collection
    end
  end

  resources :carts, only: [:create, :show] do
    get "checkout", on: :member, to: "carts#checkout"
    post "stripe_session", on: :member, to: "carts#stripe_session"
    get "success", on: :member, to: "carts#success"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
