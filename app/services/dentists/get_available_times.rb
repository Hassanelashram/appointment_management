module Dentists
  class GetAvailableTimes
    def initialize(dentist, start_date, end_date)
      @dentist = dentist
      @start_date = start_date.to_time.localtime
      @end_date = end_date.to_time.localtime
    end

    def call
      total_slots = []

      # calculate how many 30 minutes slots are in a day ( easy thanks to rails 6.1)
      day_span = 10.hours.in_minutes
      number_of_slots = (day_span / 30).to_i

      # for each day within the range inputed, we will output the slots
      # then remove the already booked ones
      while @start_date <= @end_date
        active_day = @start_date.beginning_of_day + + Dentist::DAY_START.to_i.hours

        total_slots += number_of_slots.times.with_object([active_day]) do |_index, slots|
          slots << slots.last + 30.minutes
        end

        @start_date += 1.day

        total_slots -= booked_slots(active_day)
      end

      total_slots
    end

    private

    attr_accessor :dentist, :start_date, :end_date

    def booked_slots(day)
      appointments(day).concat(lunch_time(day)).map do |time|
        time.to_time
      end
    end

    def appointments(day)
      Appointment.where(
        dentist: dentist,
        start_date: day..day + 10.hours
      ).pluck(:start_date)
    end

    def lunch_time(day)
      # 🤢 this is outrageous ahah. . .
      [day.beginning_of_day + Dentist::LUNCH_START.to_i.hours,
       day.beginning_of_day + (Dentist::LUNCH_START.to_i.hours + 30.minutes)]
    end

    def day_span
      # the day starts at 08:00 and ends at 18:00. The span is 10 hours
      # but we then substract 30 minutes from it as there should be no meeting at 18:00
      (Dentist::DAY_END.to_i - Dentist::DAY_START.to_i).hours.in_minutes - 30
    end
  end
end
