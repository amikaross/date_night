class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true 
  validates_presence_of :password

  has_secure_password

  def token 
    EncryptionService.decrypt(encrypted_token)
  end

  def token=(value)
    self.encrypted_token = EncryptionService.encrypt(value)
  end

  def refresh_token 
    EncryptionService.decrypt(encrypted_refresh_token)
  end

  def refresh_token=(value)
    self.encrypted_refresh_token = EncryptionService.encrypt(value)
  end
end