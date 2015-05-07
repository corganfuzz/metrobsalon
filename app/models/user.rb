class User < ActiveRecord::Base
  has_many :orders, :dependent => :destroy
  has_many :appointments
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_format_of :username, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "- Please enter phone number in xxx-xxx-xxxx format" }
  validates :email, presence: true, format: { with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i, message: "- Email must be in xxxx@xxxxxx.com format" }, uniqueness: true, length: { maximum: 50 }



  attr_accessor :password
  before_save :prepare_password
=begin
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /(?=.*[A-Za-z._@])/, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
=end
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end