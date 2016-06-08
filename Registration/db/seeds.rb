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


# People who adds pubs
c1 = Creator.create(name: 'Jasmin', email: 'jasmin@test.se', password: 'jasmin1', password_confirmation: 'jasmin1')
c2 = Creator.create(name: 'selma', email: 'selma@test.se', password: 'selma2', password_confirmation: 'selma2')

# Positions with pubs (One position can have more pubs, for example location of some shoping center)
p1 = Position.create(address: "Möllevångsgatan 33, Malmö")
p2 = Position.create(address: "Möllevångstorget 8, Malmö")
p3 = Position.create(address: "Per Weijersgatan 4, Malmö")

# Some tags
t1 = Tag.create(name: "beer")
t2 = Tag.create(name: "fridayevening")
t3 = Tag.create(name: "football")

# Add pubs
pub1 = Pub.create(name: "Malmö Brygghus", description: "Malmö Brewing co och Taproom är Malmös enda pubbryggeri med tillverkning och servering av kvalitetsöl i samma byggnad där Richters bryggerier höll till 1889-1912. Stora ölhallen passar utmärkt för större arrangemang som firmafester eller högtider.", rating: 4)
pub2 = Pub.create(name: "Nyhavn Malmö", description: "Uteserveringen stänger 23:00 Måndag-torsdag samt söndag. Fredag-lördag stänger uteserveringen 01:00.
Restaurangen stänger 01:00 alla dagar.", rating: 3)
pub3 = Pub.create(name: "Fegans Malmö", description: "Located in the City Center of Malmö in the fast growing Öresunds region. It is a Great Venue to Gather with Friends and Family or to 
Meet New Friends, a Great Place to Wind Down After Work with a Pint of Your Favorite Beer, a Good Meal, and a Pleasant Conversation.
Listen to some Traditional Irish and Contemporary Music.", rating: 5)

# Add tags to pubs
pub1.tags << t1
pub2.tags << t2
pub3.tags << t3
pub1.tags << t3
pub3.tags << t2

# Add pubs to creators
c1.pubs << pub1
c1.pubs << pub3
c2.pubs << pub2

#pub1.position = p1
#pub2.position = p2
#pub3.position = p3



#Couple pubs to positions
p1.pubs << pub1
p2.pubs << pub2
p3.pubs << pub3

