class Hotel < ApplicationRecord
  belongs_to :city
  has_many :check_in_dates, dependent: :destroy

  validates :name, presence: true
end