class SendgridAllcontactService
  def initialize(api_key)
    @sg = SendGrid::API.new(api_key: api_key)
  end



  def add_all_users(users)
    contacts = users.map { |user| {
         email: user.email,
        #  address_line_1: user.address_line_1,
         address_line_2: user.address_line_2,
         city: user.city,
        #  country: user.country,
         phone_number_id: user.phone_number,
         first_name: user.first_name,
         last_name: user.last_name,
        #  postal_code: user.postal_code,
         } }

    data = {
      contacts: contacts
    }

    # def add_user
    #       data = {
    #         contacts: [
    #           {
    #             email: "Nagendra@example.com",
    #             address_line_1: "123 Main Street",
    #             address_line_2: "Apt 101",
    #             city: "New York",
    #             country: "USA",
    #             first_name: "John",
    #             last_name: "Doe",
    #             # phone_number_id: "123 Main Street",
    #             # postal_code: "12345",
    #             # state_province_region: "djklfjlkd",
    #           }
    #         ]
    #       }

        response = @sg.client.marketing.contacts.put(request_body: data)
    
        if (response.status_code == 200)
        { success: true, message: 'Users added/updated successfully' }
        else
        { success: false, message: "Error: #{response.status_code} - #{response.body}" }
        end
    end
end