Rails.application.routes.draw do

  root 'static_pages#home'

  get 'static_pages/home'

  get  '/register',  to: 'users#new'

  post 'register',  to: 'users#create'

  get 'edit/user', to: 'users#edit'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  get 'register/verify', to: 'confirmations#new'

  post "register/verify", to: 'confirmations#create'

  post "register/resend", to: 'confirmations#resend_code'

  get '/orders', to: 'orders#index'

  get 'orders/confirm', to: 'order_confirmation#new'

  post 'orders/confirm', to: 'order_confirmation#create'

  get 'orders/delete', to: 'orders#delete'

  post 'orders/delete', to: 'orders#destroy'

  get 'dashboard/dashboard'

  get 'dashboard/users'

  get 'dashboard/orders', to: 'dashboard#orders'

  delete 'dashboard/users', to: 'dashboard#destroy'

  resources :users, only: [:new, :create, :show]

  resources :orders do
    # get "delete"
    resources :orders
  end

  resources :orders, only:[:new, :edit, :update, :delete, :destroy]

  resources :confirmations, only: [:new, :create]

  # # defaults to dashboard
  # root :to => redirect('/dashboard/dashboard_v1')
  #
  # # view routes
  # get '/widgets' => 'widgets#index'
  # get '/documentation' => 'documentation#index'
  #

  #
  # # api routes
  # get '/api/documentation' => 'api#documentation'
  # get '/api/datatable' => 'api#datatable'
  # get '/api/jqgrid' => 'api#jqgrid'
  # get '/api/jqgridtree' => 'api#jqgridtree'
  # get '/api/i18n/:locale' => 'api#i18n'
  # post '/api/xeditable' => 'api#xeditable'
  # get '/api/xeditable-groups' => 'api#xeditablegroups'
  #
  # # the rest goes to root
  # get '*path' => redirect('/')
end
