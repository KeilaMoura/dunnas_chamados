class Block < ApplicationRecord
  has_many :units, dependent: :destroy

  validates :name, :total_floors, :units_per_floor, presence: true
  after_create -> { GenerateUnitsService.new(self).call }

  def total_units
    total_floors * units_per_floor
  end

end