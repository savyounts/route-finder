# require_relative "spec_helper"
#
# def app
#   ApplicationController
# end
#
#   describe "Homepage" do
#     it 'loads the homepage' do
#       get '/'
#       expect(last_response.status).to eq(200)
#       expect(last_response.body).to include("Route Finder")
#     end
#   end
#
#   describe "Signup Page" do
#
#     it 'loads the signup page' do
#       get '/signup'
#       expect(last_response.status).to eq(200)
#     end
#
#     it 'signup directs user to user page' do
#       params = {
#         :username => "skittles123",
#         :password => "rainbows"
#       }
#       user = User.create(:username => "becky567", :password => "kittens")
#       post '/signup', params
#       expect(last_response.location).to include("/users/#{user.id}")
#     end
#
#     it 'does not let a user sign up without a username' do
#       params = {
#         :username => "",
#         :password => "rainbows"
#       }
#       post '/signup', params
#       expect(last_response.location).to include('/signup')
#     end
#
#
#     it 'does not let a user sign up without a password' do
#       params = {
#         :username => "skittles123",
#         :password => ""
#       }
#       post '/signup', params
#       expect(last_response.location).to include('/signup')
#     end
#
#     it 'creates a new user and logs them in on valid submission and does not let a logged in user view the signup page' do
#       params = {
#         :username => "skittles123",
#         :password => "rainbows"
#       }
#       post '/signup', params
#       get '/signup'
#       expect(last_response.location).to include('/routes')
#     end
#   end
#
#   describe "login" do
#     it 'loads the login page' do
#       get '/login'
#       expect(last_response.status).to eq(200)
#     end
#
#     it 'loads the user page after login' do
#       user = User.create(:username => "becky567", :password => "kittens")
#       params = {
#         :username => "becky567",
#         :password => "kittens"
#       }
#       post '/login', params
#       expect(last_response.status).to eq(302)
#       follow_redirect!
#       expect(last_response.status).to eq(200)
#       expect(last_response.body).to include("Welcome,")
#     end
#
#     it 'does not let user view login page if already logged in' do
#       user = User.create(:username => "becky567", :password => "kittens")
#       params = {
#         :username => "becky567",
#         :password => "kittens"
#       }
#       post '/login', params
#       get '/login'
#       expect(last_response.location).to include("/users/#{user.id}")
#     end
#   end
#
#   describe "logout" do
#     it "lets a user logout if they are already logged in" do
#       user = User.create(:username => "becky567", :password => "kittens")
#
#       params = {
#         :username => "becky567",
#         :password => "kittens"
#       }
#       post '/login', params
#       get '/logout'
#       expect(last_response.location).to include("/")
#     end
#
#     it 'does not let a user logout if not logged in' do
#       get '/logout'
#       expect(last_response.location).to include("/")
#     end
#
#     it 'does not load /routes if user not logged in' do
#       get '/routes'
#       expect(last_response.location).to include("/login")
#     end
#
#     it 'does load /routes if user is logged in' do
#       user = User.create(:username => "becky567", :password => "kittens")
#
#
#       visit '/login'
#
#       fill_in(:username, :with => "becky567")
#       fill_in(:password, :with => "kittens")
#       click_button 'submit'
#       expect(page.current_path).to eq('/routes')
#     end
#   end
#
#   describe 'user show page' do
#     it 'shows all a single users routes' do
#       user = User.create(:username => "becky567", :password => "kittens")
#       route1 = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#       rs1 = RouteStatus.create(user_id: 1, route_id: 2, status: "sent" , current_issue: "so hard", climb_style: "lead")
#       route2 = Route.create(name: "The Other Route", color: "Blue", grade: "5.10a", location: "ET Golden")
#       rs2 = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#       get "/users/#{user.id}"
#
#       expect(last_response.body).to include("The Route")
#       expect(last_response.body).to include("The Other Route")
#
#     end
#   end
#
#   describe 'index action' do
#     context 'logged in' do
#       it 'lets a user view the routes index if logged in' do
#         user1 = User.create(:username => "becky567", :password => "kittens")
#         route1 = Route.create(name: "The Other Route", color: "Blue", grade: "5.10a", location: "ET Golden")
#         rs1 =  RouteStatus.create(user_id: user1.id, route_id: route1.id, status: "sent" , current_issue: "so hard", climb_style: "lead")
#
#         user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
#         route2 = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs2 = RouteStatus.create(user_id: user2.id, route_id: route2.id, status: "sent" , current_issue: "so hard", climb_style: "lead")
#
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit "/routes"
#         expect(page.body).to include(route1.name)
#         expect(page.body).to include(route2.name)
#       end
#     end
#
#     context 'logged out' do
#       it 'does not let a user view the routes index if not logged in' do
#         get '/routes'
#         expect(last_response.location).to include("/login")
#       end
#     end
#   end
#
#   describe 'new action' do
#     context 'logged in' do
#       it 'lets user view new route form if logged in' do
#         user = User.create(:username => "becky567", :password => "kittens")
#
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit '/routes/new'
#         expect(page.status_code).to eq(200)
#       end
#
#       it 'lets user create a route if they are logged in' do
#         user = User.create(:username => "becky567", :password => "kittens")
#
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#
#         visit '/routes/new'
#         fill_in(route[:name] => "The Route", route[:color] => "Blue", route[:grade] =>  "5.10c", route[:location] =>  "ET Englewood", route_status[:status] => "sent" , route_status[:current_issue ] => "so hard", route_status[:climb_style ] => "lead")
#         click_button 'submit'
#
#         user = User.find_by(:username => "becky567")
#         route = Route.find_by(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.find_by(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#
#         expect(route).to be_instance_of(route)
#         expect(route.user_id).to eq(user.id)
#         expect(page.status_code).to eq(200)
#       end
#
#       it 'does not let a user tweet from another user' do
#         user = User.create(:username => "becky567", :password => "kittens")
#         user2 = User.create(:username => "silverstallion", :password => "horses")
#
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#
#         visit '/routes/new'
#
#         fill_in(route[:name] => "The Route", route[:color] =>  "Blue", route[:grade] => "5.10c", route[:location] => "ET Englewood", route_status[:status] => "sent" , route_status[:current_issue ] => "so hard", route_status[:climb_style ] => "lead")
#         click_button 'submit'
#
#         user = User.find_by(:id=> user.id)
#         user2 = User.find_by(:id => user2.id)
#         route = Route.find_by(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.find_by(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         expect(route).to be_instance_of(Route)
#         expect(rs.user_id).to eq(user.id)
#         expect(rs.user_id).not_to eq(user2.id)
#       end
#
#       it 'does not let a user create a route without a name' do
#         user = User.create(:username => "becky567", :password => "kittens")
#
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#
#         visit '/routes/new'
#
#         fill_in(:name, :with => "")
#         click_button 'submit'
#
#         expect(Route.find_by(:name => "")).to eq(nil)
#         expect(page.current_path).to eq("/routes/new")
#       end
#     end
#
#     context 'logged out' do
#       it 'does not let user view new route form if not logged in' do
#         get '/routes/new'
#         expect(last_response.location).to include("/login")
#       end
#     end
#   end
#
#   describe 'show action' do
#     context 'logged in' do
#       it 'displays a single route' do
#
#         user = User.create(:username => "becky567", :password => "kittens")
#         route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#
#         visit "/routes/#{route.id}"
#         expect(page.status_code).to eq(200)
#         expect(page.body).to include("Delete From Your Routes")
#         expect(page.body).to include(route.name)
#         expect(page.body).to include("Edit Your Status")
#         expect(page.body).to include("Add To Your Routes")
#       end
#     end
#
#     context 'logged out' do
#       it 'does not let a user view a route' do
#         user = User.create(:username => "becky567", :password => "kittens")
#         route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         get "/routes/#{route.id}"
#         expect(last_response.location).to include("/login")
#       end
#     end
#   end
#
#   describe 'edit action' do
#     context "logged in" do
#       it 'lets a user view route status edit form if they are logged in' do
#         user = User.create(:username => "becky567", :password => "kittens")
#         route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit '/routes/1/edit'
#         expect(page.status_code).to eq(200)
#         expect(page.body).to include(route.name)
#       end
#
#       it 'does not let a user edit a route status they did not create' do
#         user1 = User.create(:username => "becky567", :password => "kittens")
#         route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#
#         user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
#         route2 = Route.create(name: "The Other Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs2 = RouteStatus.create(user_id: 2, route_id: 2, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit "/routes/#{route.id}/edit"
#         expect(page.current_path).to include('/routes/#{route.id}')
#       end
#
#       it 'lets a user edit their own route status if they are logged in' do
#         user = User.create(:username => "becky567", :password => "kittens")
#         route = Route.find_by(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit '/routes/1/edit'
#
#         fill_in(route_status[:current_issue] =>  "so freaking hard")
#
#         click_button 'submit'
#         expect(RouteStatus.find_by(route_status[:current_issue] => "so freaking hard")).to be_instance_of(RouteStatus)
#         expect(RouteStatus.find_by(oute_status[:current_issue] => "so hard")).to eq(nil)
#         expect(page.status_code).to eq(200)
#       end
#     end
#
#     context "logged out" do
#       it 'does not load -- instead redirects to login' do
#         get '/routes/1/edit'
#         expect(last_response.location).to include("/login")
#       end
#     end
#   end
#
#   describe 'delete action' do
#     context "logged in" do
#       it 'lets a user delete their own route status if they are logged in' do
#         user = User.create(:username => "becky567", :password => "kittens")
#         rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit 'routes/1'
#         click_button "Delete From Your Routes"
#         expect(page.status_code).to eq(200)
#         expect(RouteStatus.find_by(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")).to eq(nil)
#       end
#
#       it 'does not let a user delete a route status they did not create' do
#         user1 = User.create(:username => "becky567", :password => "kittens")
#         rs = RouteStatus.create(user_id: user1.id, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")
#
#         user2 = User.create(:username => "silverstallion", :password => "horses")
#         rs2 = RouteStatus.create(user_id: user2.id, route_id: 1, status: "sent" , current_issue: "so really hard", climb_style: "lead")
#         visit '/login'
#
#         fill_in(:username, :with => "becky567")
#         fill_in(:password, :with => "kittens")
#         click_button 'submit'
#         visit "routes/#{rs2.id}"
#         click_button "Delete From Your Routes"
#         expect(page.status_code).to eq(200)
#         expect(RouteStatus.find_by(current_issue: "so really hard")).to be_instance_of(RouteStatus)
#         expect(page.current_path).to include('/routes')
#       end
#     end
#
#     context "logged out" do
#       it 'does not load let user delete a route status if not logged in' do
#         rs = RouteStatus.create(user_id: user2.id, route_id: 1, status: "sent" , current_issue: "so really hard", climb_style: "lead")
#         visit '/routes/1'
#         expect(page.current_path).to eq("/login")
#       end
#     end
#
# end
