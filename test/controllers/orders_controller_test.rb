require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    sign_in @user
  end

  test 'should pass step1 with correct params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    assert_redirected_to step2_orders_path
  end

  test 'should not pass step1 with incorrect params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Some City'}}
    assert_redirected_to step1_orders_path
  end

  test 'should pass step2 with correct params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '2017-01-05'}}
    assert_redirected_to step3_orders_path
  end

  test 'should not pass step2 with incorrect params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '1991-01-05'}}
    assert_redirected_to step2_orders_path
  end

  test 'should pass step3 with correct params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '2017-01-05'}}
    get step3_orders_path
    post save_step_orders_path, params: {order: {hotel: 'Test Hotel 1'}}
    assert_redirected_to step4_orders_path
  end

  test 'should not pass step3 with incorrect params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '2017-01-05'}}
    get step3_orders_path
    post save_step_orders_path, params: {order: {hotel: 'Some Hotel'}}
    assert_redirected_to step3_orders_path
  end

  test 'should create order with correct params' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '2017-01-05'}}
    get step3_orders_path
    post save_step_orders_path, params: {order: {hotel: 'Test Hotel 1'}}
    get step4_orders_path
    assert_difference('Order.count', +1) do
      post orders_path
    end
  end

  test 'should redirect with missing params 1' do
    get step2_orders_path
    assert_redirected_to step1_orders_path
  end

  test 'should redirect with missing params 2' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step3_orders_path
    assert_redirected_to step2_orders_path
  end

  test 'should redirect with missing params 3' do
    get step1_orders_path
    post save_step_orders_path, params: {order: {city: 'Test City'}}
    get step2_orders_path
    post save_step_orders_path, params: {order: {date: '2017-01-05'}}
    get step4_orders_path
    assert_redirected_to step3_orders_path
  end

end