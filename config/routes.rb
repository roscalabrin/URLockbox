Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create]
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :links, only: [:update]
    end
  end
  
  get '/login',                     to: 'sessions#new'
  post '/login',                    to: 'sessions#create'
  delete '/logout',                 to: 'sessions#destroy'
end
