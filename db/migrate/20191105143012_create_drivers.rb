class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
       t.string    :name,                :null => false, :default => ''
       t.string    :email,               :null => false
       t.string    :password_digest,    :null => false
      t.string    :auth_token
      t.timestamps
    end
  end
end
