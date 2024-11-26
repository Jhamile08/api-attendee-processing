class AttendeesController < ApplicationController
    def logs
        attendee = Attendee.find_by(id: params[:attendee_id])
        
        if attendee
        logs = attendee.attendee_logs
        render json: logs, status: :ok
        else
        render json: { error: "Attendee not found" }, status: :not_found
        end
    end
      
end
