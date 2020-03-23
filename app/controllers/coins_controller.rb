
class CoinsController < ApplicationController
    
    # before_action  :authentication!  #commented out for testing purposes 

    def index 
        @coins = Coin.all
          #shows all coins 
        render json: {coins: @coins, status: :ok}
        
    end

    def show
        #shows a coin if it exists by it's id, else lets end know it's a bad request!


        @coin = Coin.find_by(id: params[:id])  

       if @coin
        render json: {coin: @coin, status: :ok} 
       else
        render json:{coin: @coin, status: :bad_request, msg: 'Coin does not exist!'}
       end
          
    end


 
    def create 
        #to initialy create a coin that doesnt exist if coin susccessfully saves then render ok else bad request 

        @coin = Coin.new(coin_params)
        
        if @coin.save
            
            render json: {coin: @coin, status: :ok, msg: 'Coin created!'}
        else
            render json: {status: :bad_request, msg: 'invalid coin'} 
        end
    end


    def destroy 
        # if coin exists by id destroy it else bad request 
        @coin = Coin.find_by(id: params[:id]) 

        if @coin #checking to see if coin exists (is it nil?)
            @coin.destroy #DESTROY!
            #then render fun!
            render json: {coin: @coin, status: :ok, transaction: @transaction, msg: 'Coin removed from system!'}             
        end
    end

    def update
        #updates the coin 
            @coin = Coin.find_by(id: params[:id]) #finds by coin_params 

            @coin.update(coin_params) #update 

        render json: {coin: @coin, status: :ok, msg: 'Coin Updated!'}
    end


    def available
        #shows available balance 
        @coin = Coin.new
        render json: {'Available in USD': "$#{@coin.total}", status: :ok, msg: 'Your available balance!'}
    end

   

    private

        def coin_params
            params.require(:coin).permit(:name, :value)
        end


end
