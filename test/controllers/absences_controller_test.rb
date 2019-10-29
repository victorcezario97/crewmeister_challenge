require 'test_helper'
require_relative '../../app/controllers/CmChallenge/absences.rb'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @absences = CmChallenge::Absences.new
    @download_path = Rails.root.join('public/')
  end

  test "should get index and download file" do
    if File.exist?(@download_path + 'calendar.ical')
      File.delete(@download_path + 'calendar.ical')
    end
    get root_url
    assert_response :success
    assert(File.exist?(@download_path + 'calendar.ical'))
  end

  test 'should return a list of absences including the names of the employees' do
    absence_list = @absences.get_absences
    assert_not_nil(absence_list)
    absence_list.each { |absence| assert_not_nil(absence[:name])}
  end

  test 'should generate an iCal file' do
    path = @absences.to_ical

    assert(File.exist?(path + '/calendar.ical'))
  end

end
