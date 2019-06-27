class UsersController < ApplicationController
  def edit
    @mentor = User.find_by_activation_code(params[:id])
    @availabilities = @mentor.availabilities.visible.order(:start_time)
    @menteeing_appointments = @mentor.menteeing_appointments.visible.order(:start_time)
    @mentoring_appointments = @mentor.mentoring_appointments.visible.order(:start_time)
  end
end
