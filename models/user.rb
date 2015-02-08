require 'bcrypt'

class User < Sequel::Model
  set_primary_key [:id]
  plugin :validation_helpers

  def validate
    super

    validates_presence [:username, :email_address, :password_hash]
    validates_unique :username
  end

  def password=(new_password)
    if new_password.nil? || new_password.empty?
      self.password_hash = nil
    else
      self.password_hash = BCrypt::Password.create(new_password)
    end
  end

  def authenticate?(password)
    return !self.password_hash.nil? && BCrypt::Password.new(self.password_hash) == password
  end

  def self.find_by_username(username)
    User.first(:username => username)
  end
end
