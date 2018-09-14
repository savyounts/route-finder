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
    binding.pry
    @rs = RouteStatus.create(params[:route_status])
    @route = Route.create(params[:route])
    @route.route_statuses << @rs
    current_user.route_statuses << @rs
    redirect "/routes/#{@route.id}"
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
      erb :"/routes/add"
    else
      redirect "/login"
    end
  end

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
      if current_user
        @rs = my_routes_status(@route, current_user)
        erb :"/routes/edit"
      else
        redirect "/routes/#{current_user.id}"
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



  helpers do
    def my_routes_status(route, user)
      route.route_statuses.find {|rs| rs.user_id == user.id}
    end

    def my_users_status(user, route)
      user.route_statuses.find {|rs| rs.route_id == route.id}
    end
  end


end
