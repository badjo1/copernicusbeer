Rails.application.routes.draw do
  resources :qrlinks
  resources :qrcodes
  resources :batches do 
    resources :labels, only: [:new, :create] 
  end
  resources :labels, only: [:show, :edit, :update, :destroy] do
    resources :qrtags, only: [:index]
    get 'search', to: 'qrtags#search', as: :search
    get 'claim',  to: 'qrtags#claim', as: :claim
    resources :qrlinks, only: [:new, :create]
    get 'default_qrlinks', to: 'qrlinks#default', as: :default_qrlinks
  end
  resources :qrlinks, only: [:edit, :update, :destroy]
  
  get '/:qr/:label/:tag', to: 'qrtags#redirect', constraints: { qr: /[q][0-9a-z]/ }, as: 'redirect'

  # get '/:qr/:id)', to: 'qrtags#show', constraints: { qr: /[q]\d{2}/ }

  # Defines the root path route ("/")
  root "qrcodes#show", defaults: { id: 9 }

  
end
