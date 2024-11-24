class AttendeesController < ApplicationController

  def summary
    
    #params[:event_id] returns the id of the event sent in the URL

    #with this consult we will find the attendee rules that belongs to that specify event and with the attendee_rules filtered
    #now he have the attendee_rule where we can get  the user_attendee_id for filter by user_attendee_id that belongs to that specific event
    @attendee_rules = AttendeeRule.where(event_id: params[:event_id])

    #now we have to collect all the attendees to the event cause we are finding attendies separectly by user_attendee_id
    all_attendees_for_event = []

    @attendee_rules.each do |attendee_rule|
      @attendees = Attendee.where(user_attendee_id: attendee_rule.user_attendee_id).to_a

      all_attendees_for_event.concat(@attendees)

      puts "This is attendents #{@attendees}"
    end
    
    
    render json: all_attendees_for_event
  end
end
