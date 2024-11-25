class AttendeesController < ApplicationController
  def create_attendees
    # Crear una instancia del servicio y obtener los tickets
    # ticket_service = TicketService.new("https://api.ejemplo.com/tickets")
    #

    # tickets = ticket_service.fetch_tickets
    tickets = {
      'tickets' => [
        { 'id' => 14 },
        { 'id' => 15 }
      ]
    }
    begin
      ActiveRecord::Base.transaction do
        tickets_array = tickets['tickets']
        created_attendees = []

        tickets_array.each do |ticket|
          attendee = Attendee.create!(
            user_attendee_id: 1,
            name: Faker::Name.name,
            email: Faker::Internet.email,
            ticket_id: ticket['id'],
            status: false
          )
          # AttendeeMailer.confirmation_email(attendee).deliver_later
          created_attendees << attendee
        end

        render json: {
          message: "#{tickets_array.size} attendees was created succesfully",
          attendees: created_attendees.as_json(only: %i[id user_attendee_id name email ticket_id status]) # JSON con campos específicos
        }, status: :ok
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
