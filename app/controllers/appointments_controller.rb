class AppointmentsController < ApplicationController
  before_action :set_dentist, only: %i[new create]
  before_action :missing_date, only: %i[new]
  def index
  end

  def new
    @available_times = formatted_time_slots
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    @appointment.dentist = @dentist
    @appointment.end_date = @appointment.start_date + 30.minutes

    if @appointment.save
      redirect_to appointments_path
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

  def formatted_time_slots
    start_date, end_date = params[:startdate].split("to")
    Dentists::GetAvailableTimes.new(@dentist, start_date, end_date).call.map do |time|
      [time.strftime("%Y/%m/%d at %H:%M"), time]
    end
  end

  def missing_date
    return if params[:startdate].include?("to")

    redirect_to @dentist
    flash[:alert] = "Please provide a start and an end date"
  end
end
