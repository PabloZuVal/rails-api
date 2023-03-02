Rails.application.routes.draw do
  resources :discounts
  resources :categories
  resources :products
  resources :detail_purcheses
  resources :purchases
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
  resources :discounts
  resources :categories
  resources :products
  resources :detail_purcheses
  resources :purchases
    namespace :api do
      namespace :v1, defaults: { format: :json } do
        get '/users', action: :users,  controller: :users
        post '/users', action: :create,  controller: :users
        get '/users/:id', action: :show,  controller: :users
        put '/users/:id', action: :updateUser, controller: :users
        delete '/users/:id', action: :deleteUser, controller: :users


        post '/users/:user_id/credit_card', action: :create, controller: :credit_cards
        get '/credit_cards', action: :index, controller: :credit_cards
        post '/credit_cards/:id', action: :show, controller: :credit_cards

        # post '/purchase/:user_id/create', action: :create, controller: :purchase
        post '/invoice/create', action: :create, controller: :invoices
        
        get '/purchase', action: :index, controller: :purchases
        post '/purchase/:user_id/create', action: :create, controller: :purchases #Implement

        post '/products/create', action: :create, controller: :products
        get '/products', action: :index, controller: :products

        post '/categories/create', action: :create, controller: :categories
        get '/categories', action: :index, controller: :categories
      end
    end
  end    

end
