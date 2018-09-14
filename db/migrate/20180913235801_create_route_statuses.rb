class CreateRouteStatuses < ActiveRecord::Migration
  def change
    create_table :route_statuses do |t|
      t.integer :user_id
      t.integer :route_id
      t.string :status
      t.text :current_issue
      t.string :climb_style
      t.timestamps
    end
  end
end
