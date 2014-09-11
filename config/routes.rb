Rails.application.routes.draw do

  root to: 'categories#index'

  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :categories, only: :show
  resources :loans, only: [:show]
  resources :users, only: [:new, :create, :index, :show]
  resource :account, only: [:show, :edit, :update]
  resource :cart, only: [:show, :update, :destroy]

  resources :orders, only: [:index, :new, :create, :show] do
    get '/cancel' => 'orders#cancel', as: :cancel
  end

  namespace :borrower do
    get '/' => 'loans#dashboard'

    resources :loans do
      get '/delete_category/:category_id' => 'loans#delete_category', as: :delete_category
      get '/add_category/:category_id' => 'loans#add_category', as: :add_category
      get '/retire' => 'loans#retire', as: :retire
    end

    resources :categories, except: [:show]
    resources :order_loans, only: [:destroy, :update]
  	resources :orders, except: [:new, :destroy] do
	    get '/update_status' => 'orders#update_status', as: :update_status
	    get '/cancel' => 'orders#cancel', as: :cancel
	    get '/remove_loan/:loan_id' => 'orders#remove_loan', as: :remove_loan
	  end

    get '/ordered' => 'orders#ordered', as: :ordered
    get '/paid' => 'orders#paid', as: :paid
    get '/completed' => 'orders#completed', as: :completed
    get '/cancelled' => 'orders#cancelled', as: :cancelled
  end

  get '/code', to: redirect('https://github.com/MarcGarreau/grubhub_v2')
end
