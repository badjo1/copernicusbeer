Rails.application.routes.draw do
  resources :qrcodes
  resources :batches do 
    member do 
      get :generate
    end    
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "batches#index"

  get '/:qr', to: 'qrcodes#show', constraints: { qr: /[q]\d{2}/ }
  
end
