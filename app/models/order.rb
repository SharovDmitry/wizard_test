class Order < ApplicationRecord
  belongs_to :user
  attr_writer :current_step

  validate :city_validation, on: [:step1, :step2, :step3, :create]
  validate :date_validation, on: [:step2, :step3, :create]
  validate :hotel_validation, on: [:step3, :create]

  STEPS = %w(step1 step2 step3 step4).freeze

  def current_step
    @current_step || STEPS.first
  end

  def next_step
    self.current_step = STEPS[STEPS.index(current_step)+1]
  end

  def city_validation
    allowed_cities = City.all.map(&:name)
    errors.add(:city, 'Invalid City') unless allowed_cities.include?(city)
  end

  def date_validation
    order_city = City.find_by(name: city)
    order_city ? allowed_dates = order_city.check_in_dates.map(&:date).uniq : allowed_dates = []
    errors.add(:date, 'Invalid Date') unless allowed_dates.include?(date)
  end

  def hotel_validation
    order_city = City.find_by(name: city)
    hotels = []

    order_city.hotels.each do |h|
      hotels << h.name if h.check_in_dates.find_by(date: date)
    end if order_city

    errors.add(:hotel, 'Invalid Hotel') unless hotels.include?(hotel)
  end

end