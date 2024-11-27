class AttendeesController < ApplicationController
  # @summary Returns a list of Attendees.
  #
  # @parameter size(query) [Integer]  Used for pagination of response data (default: 5 items per response).
  # @parameter page(query) [Integer]   choose the number of pages you want to see
  def summary
    # Params for pagination
    @size = (params[:size].to_i > 0 ? params[:size].to_i : 5) # Default to 5 if size is not provided
    @page = (params[:page].to_i > 0 ? params[:page].to_i : 1) # Default to page 1 if page is not provided

    # Fetch all attendees
    @attendees = Attendee.all

    # Simulating tickets (to be replaced by actual ticket retrieval logic)
    tickets = {
      'tickets' => [
        { id: 1, event_id:  1 },
        { id: 2, event_id:  1 },
        { id: 3, event_id:  1 },
        { id: 4, event_id:  1 },
        { id: 5, event_id:  1 },
        { id: 6, event_id:  2 },
        { id: 7, event_id:  2 },
        { id: 8, event_id:  2 }
      ]
    }

    true_attendees = 0
    false_attendees = 0
    all_attendees_for_event = []

    # Iterate through attendees and match them with tickets
    @attendees.each do |attendee|
      tickets['tickets'].each do |ticket|
        next unless attendee.ticket_id.present? && ticket[:id].present? && attendee.ticket_id.to_i == ticket[:id]

        # Check if the attendee is for the correct event
        next unless params[:event_id].to_i == ticket[:event_id]

        all_attendees_for_event << attendee
        if attendee.status
          true_attendees += 1
        else
          false_attendees += 1
        end
      end
    end

    # Handle empty event case to avoid division by zero
    if all_attendees_for_event.size == 0
      render json: { error: 'No attendees found for the event' }, status: 404
      return
    end

    # Pagination logic with division by zero prevention
    total_attendees = all_attendees_for_event.size

    # Validate that the page and size parameters result in valid indices
    start_index = (@page - 1) * @size
    end_index = [start_index + @size - 1, total_attendees - 1].min

    # Ensure that pagination indices are valid (avoid negative values or out-of-bounds)
    if start_index >= total_attendees
      render json: { error: 'Page number out of range' }, status: 400
      return
    end

    paginated_attendees = all_attendees_for_event[start_index..end_index]

    # Event capacity
    event_capacity = 100
    total_registered = true_attendees + false_attendees
    available_capacity = event_capacity - total_registered

    # Prepare the response
    result = {
      event_capacity: event_capacity,
      attendants: true_attendees,
      non_attendants: false_attendees,
      tickets_not_sold: available_capacity,
      attendees: paginated_attendees
    }

    render json: result
  end
end
