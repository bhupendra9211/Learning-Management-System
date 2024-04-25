class SendgridContactService
  def initialize(api_key, email)
    @sg = SendGrid::API.new(api_key: api_key)
    @email = email
  end

  def add_or_update_user_email  
    data = {
      contacts: [
        {
          email: @email
        }
      ]
    }

    response = @sg.client.marketing.contacts.put(request_body: data)
    
    if response.status_code == 200
      { success: true, message: 'User email added/updated successfully' }
    else
      { success: false, message: "Error: #{response.status_code} - #{response.body}" }
    end
  end
end

# class SendgridContactService
#   def initialize(api_key)
#     @sg = SendGrid::API.new(api_key: api_key)
#   end

#   def add_or_update_users(users)
#     contacts = users.map { |user| { email: user.email } }

#     data = {
#       contacts: contacts
#     }

#     response = @sg.client.marketing.contacts.put(request_body: data)
    
#     if response.status_code == 200
#       { success: true, message: 'Users added/updated successfully' }
#     else
#       { success: false, message: "Error: #{response.status_code} - #{response.body}" }
#     end
#   end
# end


