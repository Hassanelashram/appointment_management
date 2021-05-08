class AppointmentsController < ApplicationController
  before_action :set_dentist, only: %i[new create]
  def index
  end

  def new
    start_date, end_date = params[:startdate].split("to")
    @available_times = Dentists::GetAvailableTimes.new(@dentist, start_date, end_date).call
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    @appointment.dentist = @dentist
    @appointment.end_date = @appointment.start_date + 30.minutes

    if @appointment.save
      redirect_to dentist_path(@dentist)
      flash[:notice] = "Appointment created"
    else
      flash[:notie] = @appointment.errors.full_messages
    end
  end

  private

  def set_dentist
    @dentist = Dentist.find(params[:dentist_id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_date)
  end
end
