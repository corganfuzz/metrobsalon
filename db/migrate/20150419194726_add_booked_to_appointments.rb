class AddBookedToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :booked, :boolean
  end
end
