class SendgridDeleteContactService   
    def initialize(api_key)
        @sg = SendGrid::API.new(api_key: api_key)
        # @sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    end

    def delete_contact
        params = JSON.parse('{
  "delete_all_contacts": "true"
}')

response = @sg.client.marketing.contacts.delete(query_params: params)
puts response.status_code
puts response.headers
puts response.body
    end

end