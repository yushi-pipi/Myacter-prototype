# frozen_string_literal: true

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @activity = @user.activities.build(title: 'Lorem ipsum', category: 'stady', user_id: @user.id)
  end

  test 'should be valid' do
    assert @activity.valid?
  end

  test 'user id should be present' do
    @activity.user_id = nil
    assert_not @activity.valid?
  end

  test 'title should be present' do
    @activity.title = '   '
    assert_not @activity.valid?
  end

  test 'category should be present' do
    @activity.category = '   '
    assert_not @activity.valid?
  end

  test 'order should be most recent first' do
    assert_equal activities(:two), Activity.first
  end
end
