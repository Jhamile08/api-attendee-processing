# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed for UserAttendee
user_attendee = UserAttendee.find_or_create_by(event_id: 1) do |ua| # Avoid duplicate test
  ua.quantity_tickets = 10
end

# Seed for Attendee
attendee = Attendee.find_or_create_by(ticket_id: 'TICKET-12345') do |att| # Avoid duplicate test
  att.user_attendee = user_attendee
  att.name = 'John Doe'
  att.email = 'john.doe@example.com'
  att.status = true # Initially active
end

attendee = Attendee.find_or_create_by(ticket_id: 'TICKET-12365') do |att| # Avoid duplicate test
  att.user_attendee = user_attendee
  att.name = 'Pepe Doe'
  att.email = 'Pepe.doe@example.com'
  att.status = true # Initially active
end

# Optional: Add AttendeeLogs for testing
attendee.attendee_logs.find_or_create_by(description: 'Initial log entry.')

puts "Seeded Attendee with ID: #{attendee.id}"

# Users that buy the tickets for his family/friends
UserAttendee.create(event_id: 1, quantity_tickets: 3)
Attendee.create(user_attendee_id: 1, ticket_id: 1, name: 'Santiago', email: 'santiago@gmail.com', status: true)
Attendee.create(user_attendee_id: 1, ticket_id: 2, name: 'Laura', email: 'laura@gmail.com', status: true)
Attendee.create(user_attendee_id: 1, ticket_id: 3, name: 'Carolina', email: 'carolina@gmail.com', status: true)
AttendeeRule.create(user_attendee_id: 1, event_id: 1, title: 'concierto Shakira', description: 'Concierto en Medellin')

UserAttendee.create(event_id: 2, quantity_tickets: 4)
Attendee.create(user_attendee_id: 2, ticket_id: 4, name: 'Carmen', email: 'carmen@gmail.com', status: true)
Attendee.create(user_attendee_id: 2, ticket_id: 5, name: 'Sara', email: 'sara@gmail.com', status: true)
Attendee.create(user_attendee_id: 2, ticket_id: 6, name: 'Gertrudis', email: 'gertrudis@gmail.com', status: false)
AttendeeRule.create(user_attendee_id: 2, event_id: 1, title: 'concierto Shakira', description: 'Concierto en Medellin')

UserAttendee.create(event_id: 3, quantity_tickets: 5)
Attendee.create(user_attendee_id: 3, ticket_id: 1, name: 'Pedro', email: 'pedro@gmail.com', status: true)
Attendee.create(user_attendee_id: 3, ticket_id: 2, name: 'Simon', email: 'simon@gmail.com', status: true)
Attendee.create(user_attendee_id: 3, ticket_id: 3, name: 'Jesus', email: 'jesus@gmail.com', status: false)
AttendeeRule.create(user_attendee_id: 3, event_id: 2, title: 'Pasar a Globant',
                    description: 'Los 15 coders que pasaran a Globant')

UserAttendee.create(event_id: 4, quantity_tickets: 2)
Attendee.create(user_attendee_id: 4, ticket_id: 1, name: 'Ken', email: 'ken@gmail.com', status: true)
Attendee.create(user_attendee_id: 4, ticket_id: 2, name: 'Kaka', email: 'kaka@gmail.com', status: true)
AttendeeRule.create(user_attendee_id: 4, event_id: 3, title: 'MeetUp Rails', description: 'MeetUp Rails in Riwi')

# Crea algunos registros para user_attendees
user_attendee1 = UserAttendee.create!(event_id: 101, quantity_tickets: 10)
user_attendee2 = UserAttendee.create!(event_id: 102, quantity_tickets: 5)

# Crea algunos registros para attendees asociados a los user_attendees
attendee1 = Attendee.create!(
  user_attendee_id: user_attendee1.id,
  ticket_id: 'TICKET-20011',
  name: 'John Doe',
  email: 'johnd1o2e@example.com',
  status: true
)

attendee2 = Attendee.create!(
  user_attendee_id: user_attendee1.id,
  ticket_id: 'TICKET-20021',
  name: 'Jane Smith',
  email: 'janes2mit1h@example.com',
  status: false
)

attendee3 = Attendee.create!(
  user_attendee_id: user_attendee2.id,
  ticket_id: 'TICKET-20031',
  name: 'Alex Johnson',
  email: 'alexjoh2nson1@example.com',
  status: true
)

# Crea algunos registros para attendee_logs relacionados a los attendees
AttendeeLog.create!(
  attendee_id: attendee1.id,
  description: 'Attendee checked in at the event.'
)

AttendeeLog.create!(
  attendee_id: attendee2.id,
  description: 'Attendee attended workshop A.'
)

# Crea algunos registros para attendee_rules
AttendeeRule.create!(
  user_attendee_id: user_attendee1.id,
  event_id: 101,
  title: 'No Alcohol Policy',
  description: 'No alcohol is allowed at the event.'
)

AttendeeRule.create!(
  user_attendee_id: user_attendee1.id,
  event_id: 102,
  title: 'Entry Time',
  description: 'Attendees should arrive 30 minutes before the event starts.'
)
