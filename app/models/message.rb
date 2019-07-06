# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user_message, class_name: 'User'
  belongs_to :specific_message, class_name: 'User', optional: true
end
