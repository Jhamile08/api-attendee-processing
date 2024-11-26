class AttendeesController < ApplicationController
    def create
      event_name = params[:event_name]  # Nombre del evento
      attendee_limit = params[:attendee_limit].to_i  # Límite de asistentes
  
      # Verificar si ya se ha alcanzado el límite de asistentes para este evento
      current_attendees_count = Attendee.where(event_name: event_name).count
      if current_attendees_count >= attendee_limit
        render json: { error: "Event capacity reached" }, status: :unprocessable_entity
        return
      end
  
      # Registrar asistentes con estado 'false' (pendiente de confirmación)
      emails = params[:attendees][:emails]
      emails.each do |email|
        Attendee.create(
          ticket_id: SecureRandom.hex(10),  # Generar un ticket ID único
          name: params[:attendees][:name],  # Nombre del asistente (puedes agregarlo al JSON)
          email: email,
          status: false,  # Asistente creado como pendiente (no confirmado)
          event_name: event_name  # Asignar el nombre del evento
        )
      end
  
      # Enviar correos de confirmación
      AttendeeMailer.confirmation_email(event_name, emails).deliver_now
  
      render json: { message: "Attendees registered successfully" }, status: :created
    end
  
    def confirm
      attendee = Attendee.find_by(email: params[:email], event_name: params[:event_name], status: false)
  
      if attendee
        attendee.update(status: true)  # Confirmar el registro del asistente
        render json: { message: "Registration confirmed successfully" }, status: :ok
      else
        render json: { error: "Attendee not found or already confirmed" }, status: :not_found
      end
    end
  end
  