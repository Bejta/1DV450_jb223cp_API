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

creator1= Creator.create
creator1.name='George'
creator1.password='123123'
creator1.password_confirmation='123123'
creator1.email='test5@test.se'

creator2= Creator.create
creator2.name='Jasmin'
creator2.password='test6'
creator2.password_confirmation='test6'
creator2.email='test6@test.se'

p1 = Position.create
p1.address='Möllevångsgatan 33, Malmö'
p1.save

p2 = Position.create
p2.address = 'Möllevångstorget 8, Malmö'
p2.save

p3 = Position.create
p3.address='Per Weijersgatan 4, Malmö'
p3.save

tag1=Tag.create
tag1.name ="#beer"

tag2=Tag.create
tag2.name ="#fridayevening"

tag3=Tag.create
tag3.name ="#irishpub"

pub= Pub.create
pub.name='Malmö Brygghus'
pub.description='Malmö Brewing co och Taproom är Malmös enda pubbryggeri med tillverkning och servering av kvalitetsöl i samma byggnad där Richters bryggerier höll till 1889-1912. Stora ölhallen passar utmärkt för större arrangemang som firmafester eller högtider.'
pub.rating = 4
pub.position_id = 1
pub.creator_id = 1

pub2= Pub.create
pub2.name='Nyhavn Malmö'
pub2.description='Uteserveringen stänger 23:00 Måndag-torsdag samt söndag. Fredag-lördag stänger uteserveringen 01:00.
Restaurangen stänger 01:00 alla dagar.'
pub2.rating = 3
pub2.position_id = 2
pub2.creator_id = 1

pub3= Pub.create
pub3.name='Fegans Malmö'
pub3.description='Located in the City Center of Malmö in the fast growing Öresunds region. It is a Great Venue to Gather with Friends and Family or to 
Meet New Friends, a Great Place to Wind Down After Work with a Pint of Your Favorite Beer, a Good Meal, and a Pleasant Conversation.
Listen to some Traditional Irish and Contemporary Music.'
pub3.rating = 5
pub3.position_id = 3
pub3.creator_id = 2

pub.tag_ids = [tag1.id]
pub.save

pub.tag_ids = [tag2.id]
pub.save

pub2.tag_ids = [tag1.id]
pub2.save

pub3.tag_ids = [tag3.id]
pub.save
pub3.tag_ids = [tag1.id]
pub3.save
pub3.tag_ids = [tag2.id]
pub3.save

u = User.create
u.username = 'calle'
u.email = 'calle@test.se'
u.password = 'test1'
u.password_confirmation = 'test1'
u.admin = false
u.save