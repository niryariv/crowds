class User < ActiveRecord::Base

  acts_as_authentic :login_field => :email
  #:crypto_provider => Authlogic::CryptoProviders::Sha1 # compatible with acts_as_auth

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'Must be a valid email address'
  
  has_many :crowds
  has_many :ownerships, :through => :crowds

  def owns?(crowd)
    crowds.include?(crowd)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

end