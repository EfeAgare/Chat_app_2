# frozen_string_literal: true

class User < ApplicationRecord
  NAME_REGEX = /\w+/.freeze
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A#{NAME_REGEX}\z/i }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_EMAIL =
    /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }

  has_secure_password

  has_many :generals, foreign_key: 'user_message_id', class_name: 'Message', dependent: :destroy
  has_many :user_messages, through: :generals

  has_many :specifics, foreign_key: 'friend_message_id', class_name: 'Message', dependent: :destroy
  has_many :friend_messages, through: :specifics

  has_one_attached :image
end
