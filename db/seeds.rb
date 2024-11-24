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
user_attendee = UserAttendee.find_or_create_by(user_id: 1) do |ua| # Avoid duplicate test  
  ua.quantity_tickets = 10
end

# Seed for Attendee
attendee = Attendee.find_or_create_by(ticket_id: "TICKET-12345") do |att| # Avoid duplicate test 
  att.user_attendee = user_attendee
  att.name = "John Doe"
  att.email = "john.doe@example.com"
  att.status = true # Initially active
end

# Optional: Add AttendeeLogs for testing
attendee.attendee_logs.find_or_create_by(description: "Initial log entry.")

puts "Seeded Attendee with ID: #{attendee.id}"
