Rails.application.routes.draw do
  root to: "products#index"

  resources :products, only: %i(show) do
    member do
      post :add_cart
      post :remove_cart
    end
  end
  resource :cart, only: %i(show)
  resources :orders, only: %i(index show new create)

  get 'admin', to: redirect('admin/index')

  namespace :admin do
    get 'index', to: "home#index"

    resources :products do
      member do
        post :order_up
        post :order_top
        post :order_down
        post :order_bottom
      end
    end

    resources :users, only: %i(index edit update destroy)
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks",
  }
end
