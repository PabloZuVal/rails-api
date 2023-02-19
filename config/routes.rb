Rails.application.routes.draw do
  resources :purchases
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
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
        
      end
    end
  end    

end
