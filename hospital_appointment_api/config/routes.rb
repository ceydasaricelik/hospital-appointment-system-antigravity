Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/register', to: 'auth#register'
      post 'auth/login', to: 'auth#login'
      get 'auth/me', to: 'auth#me'

      resources :departments, only: [:index, :show]
      resources :doctors, only: [:index, :show]
      resources :appointments, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
