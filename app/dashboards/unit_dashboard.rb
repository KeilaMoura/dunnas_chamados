require "administrate/base_dashboard"

class UnitDashboard < Administrate::BaseDashboard
  
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    block: Field::BelongsTo,
    floor: Field::Number,
    number: Field::String,
    tickets: Field::HasMany,
    user_units: Field::HasMany,
   users: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

 
  COLLECTION_ATTRIBUTES = %i[
    id
    block
    floor
    number
  ].freeze

  
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    block
    floor
    number
    tickets
    users
    created_at
    updated_at
  ].freeze

 
  FORM_ATTRIBUTES = %i[
    block
    floor
    number
    tickets
    
  ].freeze

  
  COLLECTION_FILTERS = {}.freeze

  def display_resource(unit)
    "Apto #{unit.number}"
  end
  
end
