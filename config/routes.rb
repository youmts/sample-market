Rails.application.routes.draw do
  root to: "products#index"

  resources :products, only: %i(show) do
    member do
      post :add_cart
      post :remove_cart
    end
  end
  resources :cart, only: %i(index)
  resources :orders, only: %i(index show new create)

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  get 'admin', to: redirect('admin/index')
  namespace :admin do
    get 'index', to: "home#index"
    resources :products
    resources :users, only: %i(index edit update destroy)
  end
end
