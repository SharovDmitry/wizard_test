class CheckInDate < ApplicationRecord
  belongs_to :hotel

  validates :date, presence: true
end