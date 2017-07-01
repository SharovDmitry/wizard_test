class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :check_step, only: [:step2, :step3, :step4]
  before_action :current_order, except: [:index, :save_step]

  def index
    @orders = current_user.orders.all.reverse if user_signed_in?
  end

  def step1
    @cities = City.all
  end

  def step2
    city = City.find_by(name: @order.city)
    dates = city.check_in_dates.select(:date).distinct
    @dates = dates.order(:date)
  end

  def step3
    city = City.find_by(name: @order.city)
    @hotels = []
    city.hotels.each do |h|
      @hotels << h if h.check_in_dates.find_by(date: @order.date)
    end
  end

  def save_step
    session[:order_params].deep_merge!(order_params)
    @order = current_user.orders.new(session[:order_params])
    @order.current_step = session[:order_step]

    if @order.valid?(session[:order_step].to_sym)
      @order.next_step
    end

    redirect_to action: @order.current_step
  end

  def create
    if @order.save
      session[:order_params] = nil
      session[:order_step] = nil
      redirect_to root_path
    else
      redirect_to step1_orders_path, alert: 'Something went wrong. Please try again.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:city, :date, :hotel)
  end

  def check_step
    if session[:order_params].nil? || action_name == 'step2' && !session[:order_params].has_key?('city')
      redirect_to step1_orders_path
    elsif action_name == 'step3' && !session[:order_params].has_key?('date')
      redirect_to step2_orders_path
    elsif action_name == 'step4' && !session[:order_params].has_key?('hotel')
      redirect_to step3_orders_path
    end
  end

  def current_order
    session[:order_params] ||= {}
    if action_name != 'create'
      session[:order_step] = action_name
    end
    @order = current_user.orders.new(session[:order_params])
  end

end