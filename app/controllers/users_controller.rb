class UsersController < ApplicationController


  # before  do
  #   redirect "/" if !logged_in
  # end
  # GET: /users/new
  get "/login" do
    if !logged_in?
      erb :"/users/login"
    else
      redirect "/users/#{current_user.id}"
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
    if !logged_in?
      erb :"/users/signup", layout: :header_layout
    else
      redirect "/users/#{current_user.id}"
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
    if logged_in?
      @user = User.find(params[:id])
      erb :"/users/show"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
