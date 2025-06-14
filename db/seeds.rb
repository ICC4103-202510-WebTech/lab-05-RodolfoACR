# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.delete_all
Chat.delete_all
Message.delete_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('chats')
ActiveRecord::Base.connection.reset_pk_sequence!('messages')

10.times do |i|
  User.create!(
    email: "user#{i}@miuandes.cl",
    first_name: "User#{i}",
    last_name: "Test#{i}",
    password: "AAAAAA",
    password_confirmation: "AAAAAA",
    role: i == 0 ? "admin" : "user"  # First user is admin, others are regular users
  )
end

10.times do |i|
  Chat.create!(
    sender_id: "Sender#{i}",
    receiver_id: "Receiver#{10-i}"
  )
end

10.times do |i|
  Message.create!(
    chat_id: i,
    user_id: i,
    body: "This is the #{i}rd test message"
  )
end