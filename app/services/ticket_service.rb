class TicketService
  def initialize(api_url)
    @api_url = api_url
  end

  def fetch_tickets
    response = HTTParty.get(@api_url)

    return response.parsed_response if response.success?

    # Retorna la respuesta parseada si es exitosa

    raise "Error al obtener los tickets: #{response.code}"
  end
end
