class Product < ActiveRecord::Base

  # Named Scopes
  scope :available, lambda{ where("available_on < ?", Date.today) }
  scope :drafts, lambda{ where("available_on > ?", Date.today) }

  # Validations
  validates_presence_of :title
  validates_presence_of :price


end
