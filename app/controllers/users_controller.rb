class UsersController < ApplicationController

  # GET: /users/new
  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/users/login", layout: :header_layout
    end
  end

  # POST: /users
  post "/login" do
    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/users/signup", layout: :header_layout
    end
  end

  post "/signup" do
    @user = User.create(username: params[:username].downcase, password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/signup"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    redirect_if_not_logged_in('/login')
    set_user
    erb :"/users/show"
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
