# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user_attendee = UserAttendee.find_or_create_by(user_id: 1) do |ua| # Avoid duplicate test
  ua.quantity_tickets = 10
end

attendee = Attendee.find_or_create_by(ticket_id: 'TICKET-12345') do |att| # Avoid duplicate test
  att.user_attendee = user_attendee
  att.name = 'John Doe'
  att.email = 'john.doe@example.com'
  att.status = true # Initially active
end

attendee_log1 = AttendeeLog.create!(
  attendee_id: 1,
  description: 'Attendee checked in at the event.'
)

attendee_log2 = AttendeeLog.create!(
  attendee_id: 1,
  description: 'Attendee attended workshop A.'
)

# Attendee.create!(
#   id: 10
#   user_attendee_id: 1,
#   ticket_id: "TICKET-123",
#   name: "John Doe",
#   email: "johndoe@example.com",
#   status: true
# )

# Attendee.create!(
#   id: 20
#   user_attendee_id: 2,
#   ticket_id: "TICKET-456",
#   name: "Jane Smith",
#   email: "janesmith@example.com",
#   status: false
# )
UserAttendee.delete_all

# Agregar datos a la tabla user_attendees
UserAttendee.create!([
                       { event_id: 101, quantity_tickets: 2 },
                       { event_id: 102, quantity_tickets: 4 },
                       { event_id: 103, quantity_tickets: 3 },
                       { event_id: 104, quantity_tickets: 1 },
                       { event_id: 105, quantity_tickets: 5 }
                     ])
