# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
4000.times do |i|
    User.create(
        email: Faker::Internet.email ,
        password: Faker::Internet.password(min_length: 8),
        first_name: Faker::Name.first_name ,
        last_name: Faker::Name.last_name,
        address_line_1: Faker::Address.street_address,
        address_line_2: Faker::Address.city_prefix,
        city: Faker::Address.state ,
        country: Faker::Address.country ,
        phone_number: Faker::PhoneNumber.cell_phone_in_e164,
        postal_code: Faker::Address.zip_code
    )
    puts "user #{i+1} created sucessfully"
end

# contacts = []
# 1000.times do
#     contacts << {
#         email: Faker::Internet.email ,
#         password: Faker::Internet.password(min_length: 8),
#         first_name: Faker::Name.first_name ,
#         last_name: Faker::Name.last_name,
#         address_line_1: Faker::Address.full_address,
#         address_line_2: Faker::Address.street_address,
#         city: Faker::Address.city ,
#         country: Faker::Address.country ,
#         phone_number: Faker::PhoneNumber.cell_phone ,
#         postal_code: Faker::Address.postcode
#     }
#   end