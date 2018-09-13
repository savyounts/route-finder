class RoutesController < ApplicationController

  # GET: /routes
  get "/routes" do
    erb :"/routes/index.html"
  end

  # GET: /routes/new
  get "/routes/new" do
    erb :"/routes/new.html"
  end

  # POST: /routes
  post "/routes" do
    redirect "/routes"
  end

  # GET: /routes/5
  get "/routes/:id" do
    erb :"/routes/show.html"
  end

  # GET: /routes/5/edit
  get "/routes/:id/edit" do
    erb :"/routes/edit.html"
  end

  # PATCH: /routes/5
  patch "/routes/:id" do
    redirect "/routes/:id"
  end

  # DELETE: /routes/5/delete
  delete "/routes/:id/delete" do
    redirect "/routes"
  end
end
