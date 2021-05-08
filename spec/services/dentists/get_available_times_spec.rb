require 'rails_helper'

RSpec.describe Dentists::GetAvailableTimes, type: :service do
  subject { described_class.new(dentist, start_date, end_date).call }
  let(:dentist) { create(:dentist) }
  let(:start_date) { Date.today }
  let(:end_date) { Date.today + 1 }
  describe "#call" do
    context "when the service is called" do
      context "but the dentist is nil" do
        let(:dentist) { nil }

        it "returns a string that the dentist is missing" do
          expect(subject).to eq "Dentist missing"
        end
      end
      context "but the date is incomplete" do
        let(:end_date) { nil }

        it "returns a string that the date is incomplete" do
          expect(subject).to eq "Date is incomplete"
        end
      end
      context "and all argument are present" do
        let(:eight_oclock_slot) { Time.now.beginning_of_day + 8.hours }
        let(:lunch_first_part) { Time.now.beginning_of_day + 12.hours }
        let(:lunch_second_part) { Time.now.beginning_of_day + 12.5.hours }
        it "returns a list of 30 minutes slots" do
          expect(subject.class).to eq Array
          expect(subject.first).to eq eight_oclock_slot
        end

        it "does not include the lunch break" do
          expect(subject).not_to include(lunch_first_part, lunch_second_part)
        end
        context "and there are existing appointments" do
          let!(:appointment) do
            create(:appointment, dentist: dentist, start_date: Time.now.beginning_of_day + 8.hours,
                                 end_date: Time.now.beginning_of_day + 8.5.hours)
          end
          it "does not include the booked dates" do
            expect(subject).not_to include(eight_oclock_slot)
          end
        end
      end
    end
  end
end
