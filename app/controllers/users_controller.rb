class UsersController < ApplicationController
skip_before_action :authorize, only: [:create]

        def create
            user = User.create!(user_params)
            if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
            else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
            end

            # Above could also been written like so:
            
            # user = User.create!(user_params)
            # session[:user_id] = user.id
            # render json: user, status: :created
        end
        
        def show
            render json: @current_user
        end
    
        private
        def user_params
            params.permit(:username, :password_digest, :image_url, :bio)
        end
        
end
