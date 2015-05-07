class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :order_id, :null => true
      t.integer :user_id, :null => true
      t.datetime :appointmentdate, :null => true

      t.timestamps
    end
  end
end
