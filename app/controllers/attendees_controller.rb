class AttendeesController < ApplicationController
  # @summary Returns a list of Attendees.
  #
  # @parameter size(query) [Integer]  Used for pagination of response data (default: 5 items per response).
  # @parameter page(query) [Integer]   choose the number of pages you want to see
  def summary
    # Params for pagination
    @size = params[:size].nil? ? 5 : params[:size].to_i
    @page = params[:page].nil? ? 1 : params[:page].to_i

    # Simulating tickets
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

    # Get all attendees
    @attendees = Attendee.all
    all_attendees_for_event = []
    true_attendees = 0
    false_attendees = 0

    # Filtering attendees based on the event_id and ticket_id
    @attendees.each do |attendee|
      tickets['tickets'].each do |ticket|
        next unless attendee.ticket_id.to_i == ticket[:id]
        
        if params[:event_id].to_i == ticket[:event_id]
          all_attendees_for_event << attendee
          if attendee.status
            true_attendees += 1
          else
            false_attendees += 1
          end
        end
      end
    end

    # Calculate pagination
    items = all_attendees_for_event

    # Get the `size` (records per page) and `pages` (number of pages to show) from params
    items_per_page = @size # Default to 2 if not provided
    total_pages_to_show = p@page  # Default to 1 page if not provided

    # Prepare an array to store the requested paginated pages
    paginated_pages = []

    # Manually paginate the array (using Ruby array slicing)
    (1..total_pages_to_show).each do |page_number|
      # Calculate the start and end indexes for the current page
      start_index = (page_number - 1) * items_per_page
      end_index = start_index + items_per_page - 1
      
      # Slice the array to get the items for the current page
      page_items = items[start_index..end_index]

      # If no items for the current page, break the loop early
      break if page_items.nil? || page_items.empty?

      paginated_pages << {
        page: page_number,
        items: page_items
      }
    end

    # Render the response with paginated pages and metadata
    render json: {
      pages: paginated_pages,
      meta: {
        total_pages: (items.size / items_per_page.to_f).ceil,  # Total number of pages for all records
        total_count: items.size,  # Total number of records
        current_page: @page,  # Current page
        per_page: items_per_page  # Number of records per page
      }
    }
  end
end
