class RoutesController < ApplicationController

  # GET: /routes
  get "/routes" do
    @routes = Route.all
    erb :"/routes/index"
  end

  # GET: /routes/new
  get "/routes/new" do
    erb :"/routes/new"
  end

  # POST: /routes
  post "/routes" do
    @rs = RouteStatus.create(params[:route_status])
    @route = Route.create(name: params[:name], grade: params[:grade], location: params[:location])
    @route.route_statuses << @rs
    redirect "/routes/#{@route.id}"
  end

  # GET: /routes/5
  get "/routes/:id" do
    @route = Route.find(params[:id])
    erb :"/routes/show"
  end

  get '/routes/:id/add' do
    @route = Route.find(params[:id])
    erb :"/routes/add"
  end

  post '/routes/:id' do

    redirect "/routes/:id"
  end

  # GET: /routes/5/edit
  get "/routes/:id/edit" do
    erb :"/routes/edit"
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
