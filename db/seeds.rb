# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
User.create(name:'test_s1', email:'test_s1@email.com', password:'12345678',password_confirmation:'12345678', role:'superadmin')
User.create(name:'test_a1', email:'test_a1@email.com', password:'12345678',password_confirmation:'12345678', role:'admin')
User.create(name:'test_a2', email:'test_a2@email.com', password:'12345678',password_confirmation:'12345678', role:'admin')
User.create(name:'test_i1', email:'test_i1@email.com', password:'12345678',password_confirmation:'12345678', role:'instructor')
User.create(name:'test_i2', email:'test_i2@email.com', password:'12345678',password_confirmation:'12345678', role:'instructor')
User.create(name:'test_1', email:'test_1@email.com', password:'12345678',password_confirmation:'12345678', role:'student')
User.create(name:'test_2', email:'test_2@email.com', password:'12345678',password_confirmation:'12345678', role:'student')
