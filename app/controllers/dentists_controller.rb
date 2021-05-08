class DentistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_dentist, only: [:show]

  def index
    @dentists = Dentist.all
  end

  def show
  end

  private

  def set_dentist
    @dentist = Dentist.find(params[:id])
  end
end
