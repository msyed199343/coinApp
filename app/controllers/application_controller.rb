
class ApplicationController < ActionController::API


    def current_user
        return nil unless params[:api_key]
        @current_user ||= User.find_by(api_key: params[:api_key])
    end

    def sign_out
        current_user.reset_api_key!
        params[:api_key] = nil
        render json: {status: :ok, msg: :"Goodbye!"}
    end

    def sign_in(user)
        current_user = user
    end
 
    def authentication!
        unless has_key
            render json: {status: :unauthorized}
        end

    end

    def has_key
        !current_user.nil?
    end
    
end
