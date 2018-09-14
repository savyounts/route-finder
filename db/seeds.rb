10.times do
  User.create(username: Faker::Name.name, password: Faker::Beer.name)
end

20.times do
  Route.create(name: Faker::NewGirl.character, color: Faker::Beer.style, grade: Faker::Number.digit, location: Faker::Nation.capital_city)
end

40.times do
  rando_user_id = rand(1..12)
  rando_route_id = rand(1..20)
  RouteStatus.create(user_id: rando_user_id, route_id: rando_route_id, status: Faker::Zelda.location , current_issue: Faker::StrangerThings.quote, climb_style: Faker::Superhero.prefix)
end

sav =   User.create(username: "sav", password: "pass")
route = Route.create(name: "The Route", color: "Blue", grade: "5.10c", location: "ET Englewood")
rs = RouteStatus.create(user_id: 1, route_id: 1, status: "sent" , current_issue: "so hard", climb_style: "lead")


tomo =   User.create(username: "tomo", password: "pass")
route2 = Route.create(name: "The Other Route", color: "Blue", grade: "5.10a", location: "ET Golden")
rs2 = RouteStatus.create(user_id: 2, route_id: 2, status: "sent" , current_issue: "so hard", climb_style: "lead")
  