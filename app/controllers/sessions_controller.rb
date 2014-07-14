class SessionsController < ApplicationController

    def index

    end

    def show

    end

    def new

    end

    def create
        if env["omniauth.auth"]
            user = User.from_omniauth(env["omniauth.auth"])
            session[:user_id] = user.id
            redirect_to current_user
        else
            user = User.where(email: params[:email]).first
          if user && user.valid_password?(params[:password])
                session[:user_id] = user.id
                redirect_to current_user
            else
                flash[:notice] = "Invalid email or password."
                redirect_to new_session_url
            end
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "You've been signed out."
        redirect_to new_session_url
    end
end
