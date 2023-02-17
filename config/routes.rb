Rails.application.routes.draw do
  resources :qrcodes
  resources :batches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
