require "administrate/base_dashboard"

class CommentDashboard < Administrate::BaseDashboard
  
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    content: Field::Text,
    ticket: Field::BelongsTo,
    user: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  
  COLLECTION_ATTRIBUTES = %i[
    id
    content
    ticket
    user
  ].freeze

  
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    content
    ticket
    user
    created_at
    updated_at
  ].freeze

  
  FORM_ATTRIBUTES = %i[
    content
    ticket
    user
  ].freeze

  
  COLLECTION_FILTERS = {}.freeze

  
end
