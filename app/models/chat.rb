class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validate :different_users

  scope :involving, ->(user) {
    where("sender_id = ? OR receiver_id = ?", user.id, user.id)
  }
  
  private

  def different_users
    errors.add(:receiver_id, "must be different from sender") if sender_id == receiver_id
  end
end


