Rails.application.routes.draw do
    resources :transactions , :coins, :users
   

    #coins
      get '/total', to: 'coins#available'
     
    #sessions
      delete '/signout', to: 'sessions#destroy'
      post '/signin', to: 'sessions#create'

    #transactions
      get '/withdraw/:coin_id', to: 'transactions#withdraw'
      get '/withdrawals', to: 'transactions#withdrawals'
      get '/deposits', to: 'transactions#deposits'
      get '/deposit/:coin_id', to: 'transactions#deposit'
      get '/usertransactions/:user_id', to: 'transactions#userTransactions'
      get 'transactions/:id/time', to: 'transactions#transactionTime?'

  root 'coins#index'
end
