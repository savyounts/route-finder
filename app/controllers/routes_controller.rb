class RoutesController < ApplicationController

  # GET: /routes
  get "/routes" do
    if logged_in?
      @routes = Route.all
      erb :"/routes/index"
    else
      redirect "/login"
    end
  end

  # GET: /routes/new
  get "/routes/new" do
    if logged_in?
      erb :"/routes/new"
    else
      redirect "/login"
    end
  end

  # POST: /routes
  post "/routes" do
    if !params[:route].empty? && !Route.find_by(name: params[:route][:name])
      @rs = RouteStatus.create(params[:route_status])
      @route = Route.create(params[:route])
      @route.route_statuses << @rs
      current_user.route_statuses << @rs
      redirect "/routes/#{@route.id}"
    else
      redirect "/routes/new"
    end
  end

  # GET: /routes/5
  get "/routes/:id" do
    if logged_in?
      @route = Route.find(params[:id])
      erb :"/routes/show"
    else
      redirect "/login"
    end
  end

  get '/routes/:id/add' do
    if logged_in?
      @route = Route.find(params[:id])
      if current_user.routes.include?(@route)
        redirect "/routes/#{@route.id}"
      else
        erb :"/routes/add"
      end
    else
      redirect "/login"
    end
  end

  #POST -- adds new route status and links route to user
  post '/routes/:id' do
    @route = Route.find(params[:id])
    rs = RouteStatus.create(params[:route_status])
    @route.route_statuses << rs
    current_user.route_statuses << rs

    redirect "/routes/#{@route.id}"
  end

  # GET: /routes/5/edit
  get "/routes/:id/edit" do
    # binding.pry
    @route = Route.find(params[:id])
    if logged_in?
      if @route.users.include?(current_user)
        @rs = my_routes_status(@route, current_user)
        erb :"/routes/edit"
      else
        redirect "/routes/#{@route.id}"
      end
    else
      redirect "/routes/login"
    end
  end

  # PATCH: /routes/5
  patch "/routes/:id" do
    @route = Route.find(params[:id])
    @rs = my_routes_status(@route, current_user)
    @rs.status = params[:route_status][:status]
    @rs.climb_style = params[:route_status][:climb_style]
    @rs.current_issue = params[:route_status][:current_issue]
    @rs.save
    redirect "/routes/#{@route.id}"
  end

  # DELETE: /routes/5/delete
  delete "/routes/:id/delete" do
    @route = Route.find(params[:id])
    if current_user
      @route.destroy
      redirect "/routes"
    else
      redirect "/routes/#{@route.id}"
    end
  end

end
