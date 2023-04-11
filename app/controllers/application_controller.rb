class ApplicationController < ActionController::Base
        skip_forgery_protection
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?
    
        protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:image])
        end     

        def user_update_profile
            @user = current_user
            @user.image = params[:user][:image]
            @user.save
          end
          
end