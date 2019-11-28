class CarModel < ApplicationRecord
  has_one_attached :photo
  belongs_to :manufacture
  belongs_to :fuel_type
  belongs_to :category

  validates :name, presence: true
  validates :year, presence: true
  validates :car_options, presence: true

  def daily_rate
    category.daily_rate +
    category.third_party_insurance +
    category.car_insurance
  end
end
