class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer    :bus_id,    :null => false
      t.integer    :driver_id,    :null => false
      t.integer    :status,   :default => 0
      t.datetime   :start_time
      t.datetime   :end_time
      t.string    :start_location
      t.string    :end_location
      t.timestamps
    end
    add_index :trips, :bus_id
    add_index :trips, :driver_id
  end
end
