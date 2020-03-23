class UsersController < ApplicationController
   

    def index
        @users= User.all
        render json: {users: @users, status: :ok}
    end
    def create
        @user = User.new(user_params) #create new user with params 
        
           if @user.save #save it!

                #send email with api_key for new user
                send_token = UserMailer.welcome_with_api_token!(@user)
                send_token.deliver

                render json: {status: :ok, user: @user, msg: "Created, welcome!", api_key_sent_to: "#{user_params[:email]}", email: send_token}
           else
                render json: {status: :bad_request, msg: "Try Again!" }
           end
 
    end


    private

    def user_params
        params.require(:user).permit(:email, :password, :api_key, :account_type)
    end

end