class CreateRouteStatuses < ActiveRecord::Migration
  def change
    create_table :route_statuses do |t|

      t.timestamps null: false
    end
  end
end
