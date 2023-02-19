Rails.application.routes.draw do
  resources :qrlinks
  resources :qrcodes
  resources :batches do 
    resources :labels, only: [:new, :create]
    member do 
      get :generate
    end    
  end
  resources :labels, only: [:show, :edit, :update, :destroy] do
    resources :qrtags, only: [:index]
  end

  get '/:qr/:label/:tag', to: 'qrtags#show', constraints: { qr: /[q][0-9a-z]/ }

  # get '/:qr/:id)', to: 'qrtags#show', constraints: { qr: /[q]\d{2}/ }

  # Defines the root path route ("/")
  root "batches#index"

  
end
