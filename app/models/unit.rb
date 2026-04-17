class Unit < ApplicationRecord
  belongs_to :block
  has_many :user_units, dependent: :destroy
  has_many :users, through: :user_units
  has_many :tickets
  # Para exibir na tela: "Bloco A - Apto 101"
  def full_name
    "#{block.name} - Apto #{number}"
  end
end