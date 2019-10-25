require_relative './api'
require 'icalendar'
require 'date'

module CmChallenge
  class Absences

    def to_ical
      absence_list = get_absences

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

      f = File.new("calendar.ical", "w")
      f.write(cal.to_ical)

      p File.dirname(f)
    end

    def a
      p File.exist?("calendar.ical")
    end

    def get_absences
      Api.absences
    end
  end
end
