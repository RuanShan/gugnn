Rails.application.routes.draw do
  resources :page_clicks
  root to: 'site#index'

  mount Ckeditor::Engine => '/ckeditor'
  #captcha
  #mount RuCaptcha::Engine => "/rucaptcha"


  namespace :admin do
    resources :users
    resources :categories
    resources :products
    resources :category_options
    resources :images
    resources :option_values
    resources :product_option_values
    resources :blog_categories
    resources :blog_posts
    resources :messages
    root to: "categories#index"
  end

  resources :blog_posts
  resources :blog_categories do
    resources :blog_posts
  end
  resources :hot_cities

  resources :product_option_values
  resources :category_options
  resources :option_values
  resources :products
  resources :categories do
    #member do
    #  get :products #产品，以及产品过虑
    #end
  end

  devise_for :users, controllers: { passwords: 'passwords', sessions: 'sessions', registrations: 'registrations' }

  devise_scope :user do
    get '/login', to: 'sessions#new'
    get '/logout', to: 'sessions#destroy'
    post '/sessions', to: 'sessions#create'

    get 'validate_cellphone', to: 'registrations#validate_cellphone'
    post 'validate_captcha', to: 'registrations#validate_captcha'
  end

  post '/sms', to: 'sms#create'
  post '/sms/validate', to: 'sms#validate'
  get 'be_renter', to: 'site#be_renter', as: 'be_renter'

    post '/rate' => 'rater#create', :as => 'rate'
    get 'messages/index'

    get 'messages/new'

    get 'messages/create'

    get 'conversations/index'

    get 'conversations/create'

    match 'select_city' => 'site#select_city', via: [:get, :patch]

    #get '/signup', to: 'users#new', as: 'new_user'
    #post '/users', to: 'users#create'
    #get '/users/:id', to: 'users#show', as: 'user'
    ## Edit user routes
    #get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
    #patch '/users/:id', to: 'users#update'
    #delete '/users/:id', to: 'users#destroy'

    get '/login', to: 'sessions#new'
    get '/logout', to: 'sessions#destroy'
    post '/sessions', to: 'sessions#create'

    get '/map', to: 'map#get_map'

    #Mailbox Routes
    resources :conversations do
      resources :messages
    end

    namespace :my do
      resources :products do
        member do
          patch 'withdraw'
          patch 'unwithdraw'
        end
      end
      resources :account do
        collection do
        end
        member do
          match 'change_password', via: [:get, :patch]
          match 'change_profile', via: [:get, :patch]
          match 'authentication', via: [:get]
          match 'auth_idcard', via: [:get, :patch]
          match 'auth_licence', via: [:get, :patch]
        end
      end
    end


end
