require_relative './api'
require 'icalendar'
require 'date'

module CmChallenge
  class Absences

    def to_ical(user, start_date, end_date)
      absence_list = get_absences(user, start_date, end_date)

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

      File.open("#{Rails.root}/public/calendar.ical", "w") { |f| f.write cal.to_ical }
    end

    def get_absences(user, start_date, end_date)
      list = Api.absences

      if !user.nil?
        list = list.select { |absence| absence[:user_id].to_s == user }
      end

      if !start_date.nil? && !end_date.nil?
        list = list.select { |absence| Date.parse(absence[:start_date]) >= Date.parse(start_date) && Date.parse(absence[:end_date]) <= Date.parse(end_date) }
      end

      return list
    end
  end
end
