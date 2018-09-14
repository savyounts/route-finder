class UsersController < ApplicationController

  # GET: /users/new
  get "/login" do
    erb :"/users/login"
  end

  # POST: /users
  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/login"
  end

  get "/signup" do
    erb :"/users/new"
  end

  post "/singup" do
    @user = User.create(params)
    if @user.valid?
      session[user_id:] = @user.id
      redirect "/users/#{@user.id}"
    else
      redirect "/singup"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"/users/show"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = User.find(params[:id])
    erb :"/users/edit"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    @user = User.find(params[:id])
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
