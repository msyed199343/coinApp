class SessionsController < ApplicationController


    def create

        email = session_params[:email]
        password = session_params[:password]
        current_api_key = session_params[:api_key]

            #find user by api_key, email, and password provided by user(password not saved, only 
            #checked by using bcrypt backwards)

        @user = User.find_by_credentials(email, password, current_api_key)

        if @user
            # logged in
            sign_in(@user) 
                render json:{status: :ok, params: session_params, msg: "Thanks #{email}, you're in!"}
        else
            #did not login 
             render json: :error
        end
        
    end

     def destroy
        sign_out #method from application controller signs user 
     end
 


     

     private
   

     def session_params
        params.require(:session).permit(:email, :password, :api_key)
    end
end