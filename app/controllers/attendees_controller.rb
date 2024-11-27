class AttendeesController < ApplicationController
    def logs
        attendee = Attendee.find_by(id: params[:id])
        if attendee
            logs = attendee.attendee_logs
            render json:logs, status: :ok
        else
        render json: { error: "Attendee not found" }, status: :not_found
        end
    end
      
    # def log
    #     attendee = Attendee.find(params[:id])
    #         render json: attendee.attendee_logs.select(:id, :description)
    #     rescue ActiveRecord::RecordNotFound
    #         render json: { error: "Attendee not found" }, status: :not_found
    # end
end
