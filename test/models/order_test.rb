require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    sign_in @user
  end

  test 'should save order with correct params' do
    order = Order.create(city: 'Test City', date: '2017-01-05', hotel: 'Test Hotel 1',  user_id: @user.id)
    assert order.save
  end

  test 'should not save order with incorrect city' do
    order = Order.create(city: 'Some City', date: '2017-01-05', hotel: 'Test Hotel 1',  user_id: @user.id)
    assert_not order.save
  end

  test 'should not save order with incorrect date' do
    order = Order.create(city: 'Test City', date: '1991-01-05', hotel: 'Test Hotel 1',  user_id: @user.id)
    assert_not order.save
  end

  test 'should not save order with incorrect hotel' do
    order = Order.create(city: 'Test City', date: '2017-01-05', hotel: 'Some Hotel',  user_id: @user.id)
    assert_not order.save
  end

end