require_relative './api'
require 'icalendar'
require 'date'

module CmChallenge
  class Absences

    def to_ical(user)
      absence_list = get_absences(user)

      cal = Icalendar::Calendar.new

      absence_list.each do |absence|
        cal.event do |e|
          e.dtstart     = DateTime.parse(absence[:start_date])
          e.dtend       = DateTime.parse(absence[:end_date])
          e.summary     = "#{absence[:name]} is "
          if absence[:type] == "sickness"
            e.summary += "sick"
          elsif absence[:type] == "vacation"
            e.summary += "on vacation"
          else
            e.summary += absence[:type]
          end
          e.description = absence[:member_note]
          e.ip_class    = "PRIVATE"
        end
        cal.publish
      end
      p cal
      f = File.new("#{Rails.root}/public/calendar.ical", "w")
      f.write(cal.to_ical)
      f.write("aa")

      return File.dirname(f)
    end

    def get_absences(user)
      list = Api.absences

      if !user.nil?
        list = list.select { |absence| absence[:user_id].to_s == user }
      end

      return list
    end
  end
end
