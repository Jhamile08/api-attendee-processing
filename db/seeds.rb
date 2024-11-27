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

# M
