Rails.application.routes.draw do
    resources :transactions
    resources :coins
    resources :users

    #coins
      get '/total', to: 'coins#available'
      delete '/signout', to: 'sessions#destroy'
      post '/signin', to: 'sessions#create'

    #transactions
      get '/withdraw/:coin_id', to: 'transactions#withdraw'
      get '/withdrawals', to: 'transactions#withdrawals'
      get '/deposits', to: 'transactions#deposits'
      get '/deposit/:coin_id', to: 'transactions#deposit'

  root 'coins#index'
end
