require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe "GET /new" do
    subject do
      get "/dentists/#{dentist.id}/appointments/new",
          params: params
    end
    let(:params) { { startdate: "2021-05-08to2021-05-15" } }
    let(:dentist) { create(:dentist) }
    context "params[:startdate] is present" do
      it "makes a call to GetAvailableTimes" do
        allow_any_instance_of(Dentists::GetAvailableTimes)
          .to receive(:call)
        subject
      end
    end

    # TODO: implement sign in specs to test all requests
  #   context "params[:startdate] is not complete" do
  #     let(:user) { create(:user) }
  #     let(:params) { { startdate: "2021-05-08" } }
  #     it "redirect to the dentist show page" do
  #       expect(subject).to redirect_to action: :show,
  #                                      id: dentist.id
  #     end
  #   end
  # end

  # describe "POST /appointments" do
  #   subject do
  #     post "dentists/#{dentist.id}/appointments/",
  #          params: params
  #   end

  #   let(:params) { { startdate: Time.now.beginning_of_day + 8.hours }
  #   let(:dentist) { create(:dentist) }
  #   context "params[:startdate] is present" do
  #     it "creates a new appointments" do
  #       allow_any_instance_of(Dentists::GetAvailableTimes)
  #         .to receive(:call)
  #     end
  #   end
  # end
end
