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
