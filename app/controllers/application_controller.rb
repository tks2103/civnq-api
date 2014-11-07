class ApplicationController < ActionController::API

  private
    def require_login
      unless logged_in?
        render json: {}, status: 401
      end
    end


    def current_user
      return nil unless logged_in?
      @user ||= User.find_by(steamid: session[:steamid])
    end


    def logged_in?
      not session[:steamid].nil? and not session[:username].nil?
    end
end
