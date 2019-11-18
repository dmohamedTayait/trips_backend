class CreateTripLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_locations do |t|
      t.integer    :trip_id,    null: false
      t.string     :location,   null: false
      t.datetime   :start_time, null: false
      t.timestamps
    end
    add_index :trip_locations, :trip_id
  end
end
