class DentistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @dentists = Dentist.all
  end
end
