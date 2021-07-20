# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tables_to_truncate = %w(users instagram_profiles)

puts "Truncate tables: #{tables_to_truncate.join(', ')}"
ActiveRecord::Base.connection.execute("TRUNCATE #{tables_to_truncate.join(',')} RESTART IDENTITY")

puts 'Create test user'
User.create! email: 'test1@test.com', password: '123123', name: 'Test1'

puts 'Import Instagram profile: jamesaspey'
Instagram.import_profile!('jamesaspey')

puts 'Import Instagram profile: veganalysis'
Instagram.import_profile!('veganalysis')
