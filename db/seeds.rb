# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Message.delete_all
Chat.delete_all
User.delete_all

ActiveRecord::Base.connection.reset_pk_sequence!('messages')
ActiveRecord::Base.connection.reset_pk_sequence!('chats')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Crear usuarios
users = 10.times.map do |i|
  User.create!(
    email: "user#{i}@miuandes.cl",
    first_name: "User#{i}",
    last_name: "Test#{i}",
    password: "AAAAAA",
    password_confirmation: "AAAAAA",
    role: i == 0 ? "admin" : "user"
  )
end

# Crear chats (entre pares distintos)
chats = []
users.each_with_index do |sender, i|
  receiver = users[9 - i]
  next if sender == receiver

  chats << Chat.create!(
    sender_id: sender.id,
    receiver_id: receiver.id
  )
end

# Crear mensajes
chats.each_with_index do |chat, i|
  Message.create!(
    chat_id: chat.id,
    user_id: chat.sender_id,
    body: "Mensaje de prueba número #{i + 1}"
  )
end
