class TransactionsController < ApplicationController
#    before_action  :require_key 

    def index
        @transactions = Transaction.all
        render json:{ Transaction: @transactions, status: :ok}
    end

    def create
        
        @transaction = Transaction.new(
            coin_id: params[:coin_id], 
            user_id: params[:user_id]
        )

        if @transaction.save 
            render json: @transaction, status: :ok 
        else
            render json: "ERROR", status: bad_request
        end
    end

    def show
        @transaction = Transaction.find_by(id: params[:id])
        render json: {transaction: @transaction, status: :ok}
    end

    def withdrawals
        #show a list of withdrawals

        @withdrawals = Transaction.find_by(transaction_type: 'withdrawal')

        render json: {withdrawals: @withdrawals, status: :ok, msg: "All your withdrawals!"}
    end

     def withdraw
        #subtract coin from count 
        @coin = Coin.find_by(id: params[:coin_id])
            @coin.minusCoin 
            render json: @coin
            
        if @coin.count > 0
            @coin.minusCoin 

            # if count is getting lower than 5 send admins email!
            mail_admins = UserMailer.coinsLow(@coin).deliver if @coin.count < 5 
               


        #     render json: {coin: @coin, status: :ok, msg: 'Thanks for the withdrawal!', email: mail_admins} 
        #     # track transaction by initiating new Transaction instance
        #     #@transaction = Transaction.new(coin_id: self.id, user_id: self.id, type: 'Withdrawal')
        # else
        #     render json: {coin: @coin, status: :bad_request, msg: 'Coin is not in the system!'}
        end
    end

    def deposits
        #show a list of deposits
        @deposits = Transaction.find_by(transaction_type: 'deposit')

        render json: {deposits: @deposits, status: :ok, msg: "All your deposits!"}
    end

    def deposit
        @coin = Coin.find_by(id: params[:coin_id])
        @coin.refillCoin
        render json: {coin: @coin, status: :ok, msg: 'Coin Updated!'}
    end
    private

    def transaction_params
        params.require(:transaction).permit(:coin_id, :user_id, :transaction_type) 
    end
end
