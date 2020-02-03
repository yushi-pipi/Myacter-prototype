# frozen_string_literal: true

require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @activity = activities(:one)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Activity.count' do
      post activities_path, params: { activities: { title: 'title', category: 'category' } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Activity.count' do
      delete activity_path(@activity)
    end
    assert_redirected_to login_url
  end
end
