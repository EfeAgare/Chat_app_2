class User < ApplicationRecord

  validates :username, presence: true
  
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_EMAIL =
  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

  

  has_secure_password

  has_many :messages

  has_one_attached :image



end
