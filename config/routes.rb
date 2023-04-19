Rails.application.routes.draw do
  resources :invoice_products
  resources :discounts
  resources :categories
  resources :products
  resources :detail_purcheses
  resources :purchases
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
  resources :invoice_products
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

        get '/invoice', action: :index, controller: :invoices
        post '/invoice/:purchase_id/create', action: :create, controller: :invoices
        
        post '/invoice_products/:invoice_id/create', action: :create, controller: :invoice_products
        get '/invoice_products', action: :index, controller: :invoice_products
        get '/invoice_products/:invoice_id', action: :show, controller: :invoice_products

        get '/purchase', action: :index, controller: :purchases
        post '/purchase/:user_id/create', action: :create, controller: :purchases #Implement
        get '/purchase/:id', action: :show, controller: :purchases #Implement
        put '/purchase/:id', action: :update, controller: :purchases #Implement
        delete '/purchase/:id', action: :destroy, controller: :purchases #Implement

        post '/products/create', action: :create, controller: :products
        get '/products/:id', action: :show, controller: :products
        get '/products', action: :index, controller: :products
        put '/products/:id', action: :update, controller: :products

        post '/categories/create', action: :create, controller: :categories
        get '/categories', action: :index, controller: :categories

        get '/get_pokemons', action: :get_pokemons, controller: :products
      end
    end
  end    

end
