# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(username: 'knowledge', email: 'knowledgeagare157@gmail.com', password: '200efe')

Message.create(body: 'working for me', user_message_id: user.id)