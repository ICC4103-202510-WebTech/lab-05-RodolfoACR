class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  scope :involving, ->(user) {
    where("user_id = ? OR chat_id IN (?)", user.id, 
      Chat.where("sender_id = ? OR receiver_id = ?", user.id, user.id).select(:id)) 
    }
  validates :body, presence: true
end


