# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user_message, class_name: 'User'
  belongs_to :specific_message, class_name: 'User', optional: true

  # Returns a list of users @mentioned in message content.
  def mentions
    body.scan(/@(#{User::NAME_REGEX})/).flatten.map do |username|
      User.find_by(username: username)
    end.compact
  end
end
