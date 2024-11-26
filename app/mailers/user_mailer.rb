class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  # Método de confirmación de asistencia
  def confirmation(event_name, attendee_email)
    @event_name = event_name  # El nombre del evento
    @url = "http://example.com/attendees/confirm?event=#{@event_name}&email=#{attendee_email}"  # Enlace de confirmación

    # Enviar el correo de confirmación
    mail(to: attendee_email, subject: "Please confirm your registration for #{@event_name}")
  end
end
