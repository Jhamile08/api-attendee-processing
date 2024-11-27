class UserAttendeesController < ApplicationController
  def show_user_attendees
    user_attendees = UserAttendee.all
    render json: user_attendees
  end
end
