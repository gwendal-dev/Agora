class Message < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  validates :content, presence: true
  # If you want to set up a self-referential relationship where messages can quote other messages:
  belongs_to :quoted_message, class_name: "Message", optional: true, foreign_key: "quote_id"
end
