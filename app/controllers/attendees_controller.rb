class AttendeesController < ApplicationController

  def summary
    
    #params[:event_id] returns the id of the event sent in the URL

    #with this consult we will find the attendee rules that belongs to that specify event and with the attendee_rules filtered
    #now he have the attendee_rule where we can get  the user_attendee_id for filter by user_attendee_id that belongs to that specific event
    @attendees = Attendee.all

    #now we have to collect all the attendees to the event cause we are finding attendies separectly by user_attendee_id
    all_attendees_for_event = []

    #Simulating tickets
    tickets = {
      'tickets' => [
        { id: 1, event_id:  1 },
        { id: 2, event_id:  1 },
        { id: 3, event_id:  1 },
        { id: 4, event_id:  1 },
        { id: 5, event_id:  2 },
        { id: 6, event_id:  2 },
        { id: 7, event_id:  2 },
        { id: 8, event_id:  2 },
      ]
    }
    

    true_attendees = 0;
    false_attendees = 0;
    
    @attendees.each do |attendee|
      
      puts attendee
      tickets['tickets'].each do |ticket| 
        puts "Este es el tiquete de base de datos #{(attendee.ticket_id).to_i.class}"
        puts "Este es el tiquete de json #{ticket[:id].class}"
        if (attendee.ticket_id).to_i == ticket[:id]
          puts "Entro al padre"
          if params[:event_id].to_i == ticket[:event_id] 
            puts "EVENTO SIMILARES"
            all_attendees_for_event << attendee
            if attendee.status 
              true_attendees += 1
            else
              false_attendees += 1
            end
          else
            puts "NO ENTRO"
          end
        end
      end
      



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
