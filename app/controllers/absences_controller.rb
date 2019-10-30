require_relative 'CmChallenge/absences.rb'

class AbsencesController < ApplicationController
  def index
    user = params["userId"]
    start_date = params["startDate"]
    end_date = params["endDate"]
    @absences = CmChallenge::Absences.new
    @absences.to_ical(user, start_date, end_date)
    send_file("#{Rails.root}/public/calendar.ical", filename: "calendar.ical", type: "application/ical")
  end

end
