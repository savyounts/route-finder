class Route < ActiveRecord::Base
  has_many :route_statuses 
  has_many :users, through: :route_statuses 
end
