require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome, layout: :header_layout
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def my_routes_status(route, user)
      route.route_statuses.find {|rs| rs.user_id == user.id}
    end

    def my_users_status(user, route)
      user.route_statuses.find {|rs| rs.route_id == route.id}
    end

    def redirect_if_not_logged_in(path)
      if !logged_in?
        redirect path
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_route
      @route = Route.find(params[:id])
    end

  end

end
