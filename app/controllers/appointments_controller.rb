class AppointmentsController < ApplicationController
  def index
  end

  def new
    @dentist = Dentist.find(params[:dentist_id])
    start_date, end_date = params[:startdate].split("to")
    @available_times = Dentists::GetAvailableTimes.new(@dentist, start_date, end_date).call
  end
end
