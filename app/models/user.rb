class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email, :name
  validates :name, length: {maximum: 51}
  validates :password, length: { minimum: 6 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  before_save { self.email = email.downcase }
end
