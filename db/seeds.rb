# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.find_or_create_by(id: 1, name: 'Administrator', description: 'Administrator have all the rights.')
Role.find_or_create_by(id: 2, name: 'User', description: 'User can leave a comments, edit his own comments, but not delete them.')
Role.find_or_create_by(id: 5, name: 'Guest', description: 'Guest must act like guest, be polite and modest. Can only be a observer.')

User.find_or_create_by(
    id: 1,
    email: 'admin@example.com',
    encrypted_password: '$2a$10$h5KTL6JYLvELRH09.dOthOe3n/Bc5Y7SzM1mvUFkQvBziqdNyaTli',
    username: 'Admin',
    role_id: 1,
    confirmation_token: 'xys5mHra_2JvLzfsdzaK',
    confirmed_at: '2016-10-31 22:13:26.102810',
    confirmation_sent_at: '2016-10-31 22:13:18.318067'
)
