class AttendeesController < ApplicationController


  def cancel
    attendee = Attendee.find_by(id: params[:id]) # FindAttendeeById
    if attendee.nil?
      render json: { error: "Attendee not found" }, status: :not_found
      return
    end

    begin 
      ActiveRecord::Base.transaction do
        # Update Status and log cancel
        attendee.update!(status: false)

        # Calcel log
        attendee.attendee_logs.create!(
          description: "Attendee calcel the ticket"
        )
      end    

    render json: { message: "Attendee status updated and cancellation logged successfully" }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end  



  def attendee_params
    params.require(:attendee).permit(:ticket_id, :name, :email, :status)
  end
  
end

