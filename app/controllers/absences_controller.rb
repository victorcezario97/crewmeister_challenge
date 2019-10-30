require_relative 'CmChallenge/absences.rb'

class AbsencesController < ApplicationController
  def index
    user = params["userId"]

    @absences = CmChallenge::Absences.new
    path = @absences.to_ical(user)
    byebug
    send_file(path + "/calendar.ical", filename: "calendar.ical", type: "application/ical")
  end
end
