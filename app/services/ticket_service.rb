require 'net/http'
require 'uri'
require 'json'

class TicketService
  def initialize(events_id, quantity_tickets)
    @events_id = events_id
    @quantity_tickets = quantity_tickets
    @api_url = "https://api-tickets-cbbg.onrender.com/events/#{@events_id}/tickets/#{@quantity_tickets}"
  end

  # GET request (fetch ticket summary for a specific event)
  def get_tickets
    retries ||= 0
    uri = URI(@api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    request = Net::HTTP::Get.new(uri.path, { 'Content-Type' => 'application/json' })

    begin
      response = http.request(request)
      response_body = JSON.parse(response.body)

      if response.code.to_i == 200
        { success: true, data: response_body }
      else
        { success: false, error: response_body['error'] || 'Unknown error' }
      end
    rescue StandardError => e
      if (retries += 1) <= 3
        retry
      else
        { success: false, error: "Error after 3 retries: #{e.message}" }
      end
    end
  end
end
