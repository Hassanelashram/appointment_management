FactoryBot.define do
    factory :appointment do
      user { build(:user) }
      dentist { build(:dentist) }
      start_date { Date.today.beginning_of_day + 8.hours }
      end_date { Date.today.beginning_of_day + 8.5.hours }
    end
  end
  