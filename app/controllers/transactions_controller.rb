class TransactionsController < ApplicationController
#    before_action  :require_key  #commented out for testing purposes

    def index
        #show all transactions!
        @transactions = Transaction.all
        render json:{ Transaction: @transactions, status: :ok}
    end


    def create
            #create a new transaction
        @transaction = Transaction.new(transaction_params)

        if @transaction.save 
            render json: {transaction: @transaction, status: :ok }
        else
            render json: {status: :bad_request, transaction: @transaction}
        end
    end

    def show
        #shows transaction by the id of he transaction
        @transaction = Transaction.find_by(id: params[:id])
        render json: {transaction: @transaction, status: :ok}
    end

    def withdrawals
        #show a list of withdrawals

        @withdrawals = Transaction.where(transaction_type: 'withdrawal')

        render json: {withdrawals: @withdrawals, status: :ok, msg: "All your withdrawals!"}
    end

     def withdraw
        #subtract coin from count 
        @coin = Coin.find_by(id: params[:coin_id])
        @user = User.find_by(id: params[:transaction][:user_id])
           
        if @coin.count > 0
            @coin.minusCoin 

            # if count is getting lower than 5 send admins email!
            mail_admins = UserMailer.coinsLow(@coin).deliver if @coin.count < 5 

            
            #track transaction by initiating new Transaction instance
            @transaction = Transaction.new(user_id: @user.id, coin_id: @coin.id, transaction_type: "withdrawal")
            
            #save it
            @transaction.save 

            render json: {coin: @coin, status: :ok, msg: 'Thanks for the withdrawal!', transaction: @transaction, email: mail_admins} 
            
        else
            #error if bad request
            render json: {coin: @coin, status: :bad_request, msg: 'Coin is not in the system!'}
        end
    end



    def deposits
        #show a list of deposits
        @deposits = Transaction.where(transaction_type: 'deposit')

        render json: {deposits: @deposits, status: :ok, msg: "All your deposits!"}
    end

    def deposit
        #find a coin by its id

        @coin = Coin.find_by(id: params[:coin_id])
        @user = User.find_by(id: params[:transaction][:user_id])

        @coin.refillCoin #call refillCoin to +1 the save will happen in refillCoin

         #track transaction by initiating new Transaction instance
         
            @transaction = Transaction.new(coin_id: @coin.id, user_id: @user.id, transaction_type: 'deposit')

            #save it
            @transaction.save 

        render json: {coin: @coin, status: :ok, msg: 'Thank you for your deposit!'}
    end

    def userTransactions
        #check all transactions by current user 
        @transactions = Transaction.where(user_id: params[:user_id])

         render json: {coin: @transactions, status: :ok}
    end


    def transactionTime?
        #shows what time a transaction happned 
        @transaction = Transaction.find_by(id: params[:id])

        render json: {Transaction_time: @transaction[:created_at], Transaction: @transaction, status: :ok}
    end

    private

    def transaction_params
        params.require(:transaction).permit(:coin_id, :user_id, :transaction_type) 
    end
end
