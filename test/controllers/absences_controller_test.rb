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
    absence_list = @absences.get_absences(nil, nil, nil)
    assert_not_nil(absence_list)
    absence_list.each { |absence| assert_not_nil(absence[:name])}
  end

  test 'should generate an iCal file' do
    @absences.to_ical(nil, nil, nil)

    assert(File.exist?(@download_path + 'calendar.ical'))
  end

  test 'should return a list of only the absences of a given user' do
    user = "2664"
    list = @absences.get_absences(user, nil, nil)
    assert_not_empty(list)
    list.each { |absence| assert(absence[:user_id].to_s == user) }
  end

  test 'should return a list of only the absences inside the given date interval' do
    start_date = "2017-01-04"
    end_date = "2017-01-14"
    list = @absences.get_absences(nil, start_date, end_date)
    assert_not_empty(list)
    list.each { |absence| assert(Date.parse(absence[:start_date]) >= Date.parse(start_date) && Date.parse(absence[:end_date]) <= Date.parse(end_date)) }
  end

end
