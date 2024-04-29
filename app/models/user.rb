class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subjects
  has_many :messages
  validates :name, presence: true, length: { maximum: 50 }
  # Define permission to edit a message
  def can_edit?(message)
    self.id == message.user_id
  end
end
