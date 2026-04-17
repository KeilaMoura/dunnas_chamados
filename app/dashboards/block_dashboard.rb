require "administrate/base_dashboard"

class BlockDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    total_floors: Field::Number,
    units_per_floor: Field::Number,
    total_units: Field::Number.with_options(searchable: false), # Campo calculado
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # Definição das colunas da tabela de Blocos
  
  COLLECTION_ATTRIBUTES = %i[
    name
    total_floors
    units_per_floor
    total_units
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    total_floors
    units_per_floor
    total_units
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    total_floors
    units_per_floor
  ].freeze

  
  def display_resource(block)
    block.name
  end
end