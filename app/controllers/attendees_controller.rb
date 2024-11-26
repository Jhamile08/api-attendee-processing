class AttendeesController < ApplicationController

  @summary "Returns a list of Users."
  def summary
    
    #params[:event_id] returns the id of the event sent in the URL
    #
    # Params for pagination
    @size = params[:size] || 5
    @page = params[:page] || 1

    puts "This is size: #{params[:size]} and this is page #{params[:page]}"

    #with this consult we will find the attendee rules that belongs to that specify event and with the attendee_rules filtered
    #now he have the attendee_rule where we can get  the user_attendee_id for filter by user_attendee_id that belongs to that specific event
    @attendee_rules = AttendeeRule.where(event_id: params[:event_id])

    #now we have to collect all the attendees to the event cause we are finding attendies separectly by user_attendee_id
    all_attendees_for_event = []

    true_attendees = 0;
    false_attendees = 0;
    @attendee_rules.each do |attendee_rule|
      @attendees = Attendee.where(user_attendee_id: attendee_rule.user_attendee_id).to_a

      all_attendees_for_event.concat(@attendees)

      #count true attendees and false attendees
      @attendees.each do |attendee| 
        if attendee.status then
          true_attendees += 1
        else
          false_attendees += 1
        end
      end

      puts "This is attendents #{@attendees}"
    end
    
    puts "Number of attendees that will come: #{true_attendees}"
    puts "Number of attendees that will not come: #{false_attendees}"

    #FOR THE MOMENT THE CAPACITY AVAILABLE FOR EVENT WILL BE SET BY HERE, BUT IN THE EVENT ENTITY IT SHOULD BE THE CAPACITY OF THE EVENT
    event_capacity = 100

    total_registered = true_attendees + false_attendees
    puts "Total registered attendees: #{total_registered} and the rest of capacity available is: #{(event_capacity - total_registered)}"

    #generating the hash to be included
    all_attendees_for_event << { event_capacity: event_capacity, 
                                 attendants: true_attendees, 
                                 non_attendants: false_attendees, 
                                 tickets_not_sold: (event_capacity-total_registered)
                                }
    
    render json: all_attendees_for_event
  end
end
