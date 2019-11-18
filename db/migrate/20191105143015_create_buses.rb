class CreateBuses < ActiveRecord::Migration[5.2]
  def change
    create_table :buses do |t|
     	t.string    :code,                :null => false, :default => ''
      t.timestamps
    end

    add_index :buses, :code
  end
end
