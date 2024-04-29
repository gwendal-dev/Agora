class Message < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  belongs_to :quoted_message, class_name: "Message", optional: true, foreign_key: "quote_id"
  has_many :replies, class_name: "Message", foreign_key: "parent_id", dependent: :destroy

  def full_quote
    
    current_message = self
    quotes = []
    while current_message.quoted_message
      quotes << current_message.quoted_message
      current_message = current_message.quoted_message
    end
    quotes.reverse
  end
end
