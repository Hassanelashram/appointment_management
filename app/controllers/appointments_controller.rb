class AppointmentsController < ApplicationController
  def index
  end

  def new
    @dentist = Dentist.find(params[:dentist_id])
  end
end
