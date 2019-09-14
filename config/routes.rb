Rails.application.routes.draw do
  root to: "shop#index"
  resources :shop, only: %i(show)
  resources :cart, only: %i(index)
  resources :cart_items, only: [] do
    collection do
      post :add
      post :remove
    end
  end

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
