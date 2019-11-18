##
# Represents information about a Drivers.
#
class Driver < ApplicationRecord
 
  has_many :trips

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password_digest
  validates_uniqueness_of :email

  has_secure_password
  has_secure_token :auth_token
  #acts_as_paranoid

  def self.can_login?(email, password)
    driver = find_by(email: email)
    if driver && driver.authenticate(password)
      driver
    end
  end

  #set auth token 
  def set_auth_token
    self.regenerate_auth_token
    self.save
  end

  #reset auth token 
  def reset_access_token
    if self 
      self.auth_token = nil
      return self.save
    else
      return false
    end
  end

  acts_as_api
  api_accessible :basic do |template|
    template.add :id
    template.add :name
    template.add :email
    template.add :auth_token
    template.add :created_at
  end

end
