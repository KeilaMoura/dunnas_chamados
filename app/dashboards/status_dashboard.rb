require "administrate/base_dashboard"

class StatusDashboard < Administrate::BaseDashboard
 
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    is_default: Field::Boolean,
    is_final: Field::Boolean,
    name: Field::String,
    tickets: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  
  COLLECTION_ATTRIBUTES = %i[
    id
    name
  ].freeze

  
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    is_default
    is_final
    name
    tickets
    created_at
    updated_at
  ].freeze

 
  FORM_ATTRIBUTES = %i[
    is_default
    is_final
    name
  ].freeze

  
  COLLECTION_FILTERS = {}.freeze


def display_resource(status)
    status.name
  end

end
