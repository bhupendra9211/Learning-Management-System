class SendgridAllcontactService
  BATCH_SIZE = 100

  def initialize(api_key)
    @sg = SendGrid::API.new(api_key: api_key)
  end

  def add_all_users(users)
    contacts = users.map do |user|
      {
        email: user.email,
        address_line_1: user.address_line_1,
        address_line_2: user.address_line_2,
        city: user.city,
        country: user.country,
        first_name: user.first_name,
        last_name: user.last_name,
        phone_number_id: user.phone_number,
        postal_code: user.postal_code
      }
    end

    contacts.each_slice(BATCH_SIZE) do |batch|
      response = add_contacts_batch(batch)
      return response unless response[:success]
    end

    { success: true, message: 'All users added/updated successfully' }
  end

  private

  def add_contacts_batch(contacts)
    data = { contacts: contacts }
    response = @sg.client.marketing.contacts.put(request_body: data)

    if response.status_code == 200
      { success: true, message: 'Contacts batch added/updated successfully' }
    elsif response.status_code == 400 && response.body.include?('Contact Limit')
      { success: false, message: 'SendGrid contact limit reached' }
    else
      { success: false, message: "Error: #{response.status_code} - #{response.body}" }
    end
  end
end















# class SendgridAllcontactService
#   def initialize(api_key)
#     @sg = SendGrid::API.new(api_key: api_key)
#   end



#   def add_all_users(users)
#     contacts = users.map { |user| {
#          email: user.email,
#          address_line_1: user.address_line_1,
#          address_line_2: user.address_line_2,
#          city: user.city,
#          country: user.country,
#         #  phone_number_id: user.phone_number,
#          first_name: user.first_name,
#          last_name: user.last_name,
#          postal_code: user.postal_code,
#          } }

#     data = {
#       contacts: contacts
#     }

#     # def add_user
#     #       data = {
#     #         contacts: [
#     #           {
#     #             email: "Nagendra@example.com",
#     #             address_line_1: "123 Main Street",
#     #             address_line_2: "Apt 101",
#     #             city: "New York",
#     #             country: "USA",
#     #             first_name: "John",
#     #             last_name: "Doe",
#     #             # phone_number_id: "123 Main Street",
#     #             # postal_code: "12345",
#     #             # state_province_region: "djklfjlkd",
#     #           }
#     #         ]
#     #       }

#         response = @sg.client.marketing.contacts.put(request_body: data)
    
#         if (response.status_code == 200)
#         { success: true, message: 'Users added/updated successfully' }
#         else
#         { success: false, message: "Error: #{response.status_code} - #{response.body}" }
#         end
#     end
# end