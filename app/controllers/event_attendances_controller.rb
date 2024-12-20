class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    user_id = current_user.id
    event_id = event_attendance_params[:event_id]
    @attendance = EventAttendance.new(attendee_id: user_id, event_id: event_id)

    if @attendance.save
      redirect_to event_path(event_id), notice: "Signed up success!"
    else
      redirect_to event_path(event_id), status: :unprocessable_entity, alert: "Signed up fail"
    end
  end

  def destroy
    @attendance = EventAttendance.find(params[:id])

    if @attendance.attendee != current_user
      redirect_to root_path, alert: "You are not allowed to access this resource."
    end

    if @attendance.destroy
      redirect_to event_path(params[:event_id]), notice: "Attendance canceled."
    else
      redirect_to root_path, alert: "Something went wrong."
    end
  end

  private

  def event_attendance_params
    params.require(:event_attendance).permit(:event_id)
  end
end
