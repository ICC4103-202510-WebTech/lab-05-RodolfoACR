class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  has_many :messages

  validate :different_users
  validates :sender_id, :receiver_id, presence: true

  private

  def different_users
    errors.add(:receiver_id, "must be different from sender") if sender_id == receiver_id
  end
end

