require 'test_helper'
require_relative '../../app/controllers/CmChallenge/absences.rb'

class AbsencesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @absences = CmChallenge::Absences.new
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test 'should return a list of absences including the names of the employees' do
      absence_list = @absences.get_absences
      assert_not_nil(absence_list)
      absence_list.each { |absence| assert_not_nil(absence[:name])}
  end

end
