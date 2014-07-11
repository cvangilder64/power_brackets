class SessionsController < ApplicationController

    def index

    end

    def show

    end

    def new

    end

    def create
        user_omniauth = User.from_omniauth(env["omniauth.auth"])
        user = User.where(email: params[:email]).first
        if user_omniauth
            session[:user_id] = user.id
            redirect_to current_user
        else
            if user && user.authenticate(params[:password])
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
