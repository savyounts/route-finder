class User < ActiveRecord::Base
  has_many :route_statuses
  has_many :routes, through: :route_statuses

  has_secure_password
  validates :username, uniqueness: true
  validates :username, presence: true

<<<<<<< HEAD
=======

>>>>>>> additional-css
  def name
    self.username.capitalize
  end
end
