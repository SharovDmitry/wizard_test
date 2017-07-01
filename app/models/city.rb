class City < ApplicationRecord
  has_many :hotels, dependent: :destroy
  has_many :check_in_dates, through: :hotels

  validates :name, presence: true
end