class User < ActiveRecord::Base
  attr_accessible :email, :name, :isShopper, :password, :password_confirmation, :address, :contact, :status
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :contact
  validates_presence_of :address
  validates_uniqueness_of :email

  has_one :cart
  has_many :orders
  has_many :lists

  # Define constant for user status
  def self.STATUS_ADMINISTRATOR
    0
  end

  # Define constant for user status
  def self.STATUS_SHOPKEEPER
    1
  end

  # Define constant for user status
  def self.STATUS_SHOPPER
    2
  end



  #Using Bcrypt, we make sure that the password is encrypted into secure format.

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end


  #This is the actual authentication process that checks whether the input e-mail and password match with any accounts
  def self.authenticate(email,password)
    user=find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user
    else
      nil
    end
  end

end
