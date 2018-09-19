require 'rack-flash'
class RoutesController < ApplicationController
  use Rack::Flash

  before do
    redirect_if_not_logged_in("/login")
  end

  # GET: /routes
  get "/routes" do
    @routes = Route.all
    erb :"/routes/index"
  end

  # GET: /routes/new
  get "/routes/new" do
    erb :"/routes/new", layout: :header_layout
  end

  # POST: /routes
  post "/routes" do
    if !Route.find_by(name: params[:route][:name])
      @route = Route.create(params[:route])
      @route.route_statuses << @rs = RouteStatus.create(params[:route_status])
      current_user.route_statuses << @rs
      redirect "/routes/#{@route.id}"
    else
      redirect "/routes/new"
    end
  end

  # GET: /routes/5
  get "/routes/:id" do
    set_route
    erb :"/routes/show"
  end

  get '/routes/:id/add' do
    set_route
    if current_user.routes.include?(@route)
      redirect "/routes/#{@route.id}"
    else
      erb :"/routes/add", layout: :header_layout
    end
  end

  #POST -- adds new route status and links route to user
  post '/routes/:id' do
    set_route
    rs = RouteStatus.create(params[:route_status])
    @route.route_statuses << rs
    current_user.route_statuses << rs

    redirect "/routes/#{@route.id}"
  end

  # GET: /routes/5/edit
  get "/routes/:id/edit" do
    set_route
    if @route.users.include?(current_user)
      @rs = my_routes_status(@route, current_user)
      erb :"/routes/edit", layout: :header_layout
    else
      redirect "/routes/#{@route.id}"
    end
  end

  # PATCH: /routes/5
  patch "/routes/:id" do
    set_route
    @rs = my_routes_status(@route, current_user)
    @rs.update(params[:route_status])
    redirect "/routes/#{@route.id}"
  end

  # DELETE: /routes/5/delete
  delete "/routes/:id/delete" do
    set_route
    if current_user
      @rs = my_routes_status(@route, current_user)
      @rs.destroy
      redirect "/routes"
    else
      redirect "/routes/#{@route.id}"
    end
  end

end
