class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if @user
            sign_in!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ['Invalid Login']
            render :new
        end
    end

    def new
        render :new
    end

    def destroy
        sign_out!
        redirect_to new_session_url
    end
end
