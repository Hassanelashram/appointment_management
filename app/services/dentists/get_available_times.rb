module Dentists
  class GetAvailableTimes
    def initialize(dentist, start_date, end_date)
      @dentist = dentist
      @start_date = start_date.to_time
      @end_date = end_date.to_time
    end

    def call
      total_slots = []

      # calculate how many 30 minutes slots are in a day ( easy thanks to rails 6.1)
      day_span = 10.hours.in_minutes
      number_of_slots = (day_span / 30).to_i

      # for each day within the range inputed, we will output the slots
      # then remove the already booked ones
      while @start_date <= @end_date
        active_day = @start_date.beginning_of_day + 8.hours

        total_slots += number_of_slots.times.with_object([active_day]) do |_index, slots|
          slots << slots.last + 30.minutes
        end

        @start_date += 1.day

        total_slots -= Appointment.where(dentist: dentist,
                                         start_date: active_day..active_day + 10.hours).pluck(:start_date)
      end

      total_slots
    end

    private

    attr_accessor :dentist
  end
end
