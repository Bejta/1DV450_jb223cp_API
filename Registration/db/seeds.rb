# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create
admin.username = 'admin'
admin.email = 'admin@test.se'
admin.password = 'test'
admin.password_confirmation = 'test'
admin.admin = true
admin.save

u = User.create
u.username = 'calle'
u.email = 'calle@test.se'
u.password = 'test1'
u.password_confirmation = 'test1'
u.admin = false
u.save