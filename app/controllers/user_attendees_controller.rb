class UserAttendeesController < ApplicationController
  def cancel_attendees
    user_attendee = UserAttendee.find_by(id: params[:id])

    if user_attendee.nil?
      render json: { error: "UserAttendee not found" }, status: :not_found
      return
    end

    begin
      ActiveRecord::Base.transaction do
        # Iterate through associated attendees
        user_attendee.attendees.each do |attendee|
          # Update attendee status to false
          attendee.update!(status: false)

          # Log the cancellation for each attendee with custom or default message
          cancellation_message = params[:description] || "Cancellation recorded for UserAttendee ID #{user_attendee.id}: status set to false."
          attendee.attendee_logs.create!(
            description: cancellation_message
          )
        end
      end

      render json: { message: "All attendees canceled and logged successfully for UserAttendee ID #{user_attendee.id}" }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def cancel_attendee
    user_attendee = UserAttendee.find_by(id: params[:id])

    if user_attendee.nil?
      render json: { error: "UserAttendee not found" }, status: :not_found
      return
    end

    attendee = user_attendee.attendees.find_by(id: params[:attendee_id])

    if attendee.nil?
      render json: { error: "Attendee not found or not belong to UserAttendee" }, status: :not_found
      return
    end

    begin
      ActiveRecord::Base.transaction do
        # Update the specific attendee's status
        attendee.update!(status: false)
  
        # Log the cancellation for the specific attendee with custom or default message
        cancellation_message = params[:description] || "Cancellation recorded for UserAttendee ID #{user_attendee.id}: status set to false."
          attendee.attendee_logs.create!(
            description: cancellation_message
        )
      end

      render json: { message: "Attendee canceled and log sent successfully #{user_attendee.id}" }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end 
  
  
end
