class AttendeeMailer < ApplicationMailer
  default from: 'erlindr@hotmail.com'
  def confirmation_email(attendee)
    @attendee = attendee
    @confirmation_link = url_for(
      controller: 'attendees',
      action: 'confirm',
      id: @attendee.id,
      host: 'localhost:3000'
    )
    mail(
      to: @attendee.email,
      subject: 'Confirma tu asistencia'
    )
  end
end
