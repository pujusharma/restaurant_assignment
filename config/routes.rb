Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: { omniauth_controller: 'users/omniauth_controller' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/omniauth/:provider' => 'users/omniauth_controller#create'
  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :home, only: [:index]
      namespace :auth do
        resource :passwords, only: [:create, :update]
      end
    end
  end
end