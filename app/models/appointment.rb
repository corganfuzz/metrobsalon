class Appointment < ActiveRecord::Base
  belongs_to :order, foreign_key: :order_id
  belongs_to :user

  validate :future
  validates_uniqueness_of(:appointmentdate)
  def future
    if Date.today >= self.appointmentdate
      errors.add :appointmentdate, "The Appointment date must be after today"
    end
    if (appointmentdate - Time.now) < 2
      errors.add :appointmentdate, "The appointment must be booked at least 2 hours from now"
    end
  end



end
