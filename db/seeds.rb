10.times do
  User.create(username: Faker::Name.first_name, password: Faker::Beer.name)
end

5.times do
  Route.create(name: Faker::Book.title, color: Faker::Beer.style, grade: '5.10c', location: Faker::Nation.capital_city)
end

5.times do
  Route.create(name: Faker::Book.title, color: Faker::Beer.style, grade: 'V6', location: Faker::Nation.capital_city)
end

5.times do
  Route.create(name: Faker::Book.title, color: Faker::Beer.style, grade: '5.14a', location: Faker::Nation.capital_city)
end

5.times do
  Route.create(name: Faker::Book.title, color: Faker::Beer.style, grade: '5.intro', location: Faker::Nation.capital_city)
end

15.times do
  rando_user_id = rand(1..12)
  rando_route_id = rand(1..20)
  RouteStatus.create(user_id: rando_user_id, route_id: rando_route_id, status: "Scoping It Out" , current_issue: "Can't get over the crazy overhang 3/4 the way up", climb_style: "Top Rope")
end

15.times do
  rando_user_id = rand(1..12)
  rando_route_id = rand(1..20)
  RouteStatus.create(user_id: rando_user_id, route_id: rando_route_id, status: "In Progress" , current_issue: "Sloper on the 3rd move is killer", climb_style: "Bouldering")
end

15.times do
  rando_user_id = rand(1..12)
  rando_route_id = rand(1..20)
  RouteStatus.create(user_id: rando_user_id, route_id: rando_route_id, status: "Sent dat ish" , current_issue: "Pocket holds kill my fingers by the time I get close to the top", climb_style: "Lead")
end

sav =   User.create(username: "sav", password: "pass")
route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")


tomo =   User.create(username: "tomo", password: "pass")
route2 = Route.create(name: "The Other Route", color: "Blue", grade: "5.10a", location: "ET Golden")
rs2 = RouteStatus.create(user_id: 2, route_id: 2, status: "sent" , current_issue: "so hard", climb_style: "lead")
