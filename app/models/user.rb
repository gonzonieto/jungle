class User < ApplicationRecord

  has_secure_password

  validates :email, uniqueness: true

  # TODO: Add validations including:
  #   - email address presence and uniqueness
  
end