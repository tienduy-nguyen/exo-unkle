#***********************************************************************************************************************************#
#                                                       Notice                                                                      #
#                                 Before run the rails db:seed, make sure you run rails db:reset                                    #
#                                     Or run with 2 commands: rails db:drop and rails db:reset                                      #
#***********************************************************************************************************************************#
abort "only run seeds in development or test" unless Rails.env.development? or Rails.env.test?
require "faker"

User.delete_all
Option.destroy_all
Contract.destroy_all
OptionContract.destroy_all
ClientContract.destroy_all

# Create some fake user
50.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "1234567",
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    is_admin: false,
  )
end
puts "50 clients created!"

# Create an user for dev

admin = User.create(
  first_name: "admin",
  last_name: "1",
  email: "admin1@yopmail.com",
  password: "1234567",
  phone: Faker::PhoneNumber.phone_number,
  address: Faker::Address.full_address,
  is_admin: true,
)

puts "admin1@yopmail.com created!"

User.create(
  first_name: "Client",
  last_name: "1",
  email: "client1@yopmail.com",
  password: "1234567",
  phone: Faker::PhoneNumber.phone_number,
  address: Faker::Address.full_address,
  is_admin: false,
)
puts "client1@yopmail.com created!"

options = ["All guarantees", "Fire guarantee", "Theft guarantee",
           "Damage guarantee", "Vandalism guarantee", "Nature disater guarantee",
           "Health guarantee", "Guarantee of attack and act of terorism"]

options.each do |name|
  Option.create(name: name,
                description: Faker::Lorem.paragraph)
end
puts "options created!"

100.times do |i|
  pre_contract = Contract.create(
    start_date: Time.now, created_by: admin.full_name,
  )
  OptionContract.create(option_id: Option.all.sample.id, contract_id: pre_contract.id)
  3.times do |c|
    ClientContract.create(client_id: User.all.sample.id, contract_id: pre_contract.id)
  end
end
puts "100 contracts created!"

puts "Done!"
