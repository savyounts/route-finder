class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|

      t.string :name
      t.string :grade
      t.string :color, default: "none"
      t.string :location
    end
  end
end
