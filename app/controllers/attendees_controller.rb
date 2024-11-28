class AttendeesController < ApplicationController
  def cancel
    attendee = Attendee.find_by(id: params[:id]) # FindAttendeeById
    if attendee.nil?
      render json: { error: 'Attendee not found' }, status: :not_found
      return
    end

    begin
      ActiveRecord::Base.transaction do
        # Update Status and log cancel
        attendee.update!(status: false)

        # Calcel log
        attendee.attendee_logs.create!(
          description: 'Attendee calcel the ticket'
        )
      end

      render json: { message: 'Attendee status updated and cancellation logged successfully' }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def attendee_params
    params.require(:attendee).permit(:ticket_id, :name, :email, :status)
  end

  # @summary Returns a list of Attendees.
  #
  # @parameter size(query) [Integer]  Used for pagination of response data (default: 5 items per response).
  # @parameter page(query) [Integer]   choose the numer of pages you want to see
  def summary
    # params[:event_id] returns the id of the event sent in the URL
    #
    # Params for pagination
    @size = 5 if params[:size].nil?

    @page = 1 if params[:page].nil?

    puts "THIS IS SIZE: #{@size} and this is page #{@page}"

    # when send page and size convert to string

    @size = params[:size].to_i unless params[:size].nil?

    @page = params[:page].to_i unless params[:page].nil?

    # with this consult we will find the attendee rules that belongs to that specify event and with the attendee_rules filtered
    # now he have the attendee_rule where we can get  the user_attendee_id for filter by user_attendee_id that belongs to that specific event
    @attendees = Attendee.all

    # now we have to collect all the attendees to the event cause we are finding attendies separectly by user_attendee_id
    all_attendees_for_event = []
  end

  def assistants
    # params[:event_id] returns the id of the event sent in the URL

    # with this consult we will find the attendee rules that belongs to that specify event and with the attendee_rules filtered
    # now he have the attendee_rule where we can get  the user_attendee_id for filter by user_attendee_id that belongs to that specific event
    @attendees = Attendee.all

    # now we have to collect all the attendees to the event cause we are finding attendies separectly by user_attendee_id
    all_attendees_for_event = []

    # Simulating tickets

    tickets = {
      'tickets' => [
        { id: 1, event_id: 1 }
      ]
    }

    true_attendees = 0
    false_attendees = 0

    @attendees.each do |attendee|
      puts attendee
      tickets['tickets'].each do |ticket|
        puts "Este es el tiquete de base de datos #{attendee.ticket_id.to_i.class}"
        puts "Este es el tiquete de json #{ticket[:id].class}"
        next unless attendee.ticket_id.to_i == ticket[:id]

        puts 'Entro al padre'
        if params[:event_id].to_i == ticket[:event_id]
          puts 'EVENTO SIMILARES'
          all_attendees_for_event << attendee
          if attendee.status
            true_attendees += 1
          else
            false_attendees += 1
          end
        else
          puts 'NO ENTRO'
        end
      end
    end

    puts "Number of attendees that will come: #{true_attendees}"
    puts "Number of attendees that will not come: #{false_attendees}"

    # FOR THE MOMENT THE CAPACITY AVAILABLE FOR EVENT WILL BE SET BY HERE, BUT IN THE EVENT ENTITY IT SHOULD BE THE CAPACITY OF THE EVENT
    event_capacity = 100

    total_registered = true_attendees + false_attendees
    puts "Total registered attendees: #{total_registered} and the rest of capacity available is: #{event_capacity - total_registered}"

    # generating the hash to be included
    all_attendees_for_event << { event_capacity: event_capacity,
                                 attendants: true_attendees,
                                 non_attendants: false_attendees,
                                 tickets_not_sold: (event_capacity - total_registered) }

    render json: {
      event_capacity: event_capacity,
      true_attendees: true_attendees,
      false_attendees: false_attendees
    }
  end

  def logs
    attendee = Attendee.find_by(id: params[:id])
    if attendee
      logs = attendee.attendee_logs
      if logs.any?
        render json: { status: 'success', logs: logs }, status: :ok
      else
        render json: { status: 'error', message: 'No se encontraron logs para este Attendee' }, status: :not_found
      end
    else
      render json: { error: 'Attendee not found' }, status: :not_found
    end
  end

  def create_attendees
    # Crear una instancia del servicio y obtener los tickets
    # ticket_service = TicketService.new("https://api.ejemplo.com/tickets")
    #

    # tickets = ticket_service.fetch_tickets
    tickets = {
      'tickets' => [
        { 'id' => 14 }
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
            email: 'jhamiledr222@gmail.com',
            ticket_id: ticket['id'],
            status: false
          )
          AttendeeMailer.confirmation_email(attendee).deliver_later
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

  def confirm
    @attendee = Attendee.find(params[:id])

    if @attendee.update(status: true)
      # Renderizar el mensaje directamente en la misma página
      render plain: 'La asistencia ha sido confirmada correctamente.', status: :ok
    else
      render plain: 'Hubo un error al confirmar la asistencia.', status: :unprocessable_entity
    end
  end
end
