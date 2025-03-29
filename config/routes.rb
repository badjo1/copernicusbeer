Rails.application.routes.draw do
  get "login", to: "user_sessions#show"
  get "get_nonce/:id", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  get "logout", to: "user_sessions#destroy"
  resources :qrlinks
  resources :qrcodes
  resources :batches do 
    resources :labels, only: [:new, :create] 
  end
  resources :labels, only: [:show, :edit, :update, :destroy] do
    resources :qrtags, only: [:index]
    get 'search', to: 'qrtags#search', as: :search
    get 'claim',  to: 'qrtags#claim', as: :claim
    get 'unclaim_tags', to: 'qrtags#unclaim_all', as: :unclaim_tags
    resources :qrlinks, only: [:new, :create]
    get 'default_qrlinks', to: 'qrlinks#default', as: :default_qrlinks
    get 'reset_qrlinks', to: 'qrlinks#reset', as: :reset_qrlinks
    post 'qrlinks/batch', to: "qrlinks#batch", as: :qrlinks_batch #good one
  end
  resources :qrlinks, only: [:edit, :update, :destroy]
  resources :users, only: [:show] 
  resources :qrtags, only: [:show] do
    get "qrlinks/new", to: "qrtags#new_qrlink", as: :new_qrlink
    post "qrlinks", to: "qrtags#create_qrlink"
  end

  get '/:qr/:label/:tag', to: 'sites#redirect', constraints: { qr: /[q][0-9a-z]/ }, as: 'redirect'

  # get '/:qr/:id)', to: 'qrtags#show', constraints: { qr: /[q]\d{2}/ }


  get 'add_to_metamask', to: 'sites#add_to_metamask'
  # Defines the root path route ("/")
  root "sites#claimed"

  
end
