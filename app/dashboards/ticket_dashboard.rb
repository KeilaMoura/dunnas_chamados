require "administrate/base_dashboard"

class TicketDashboard < Administrate::BaseDashboard
  
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    attachments_attachments: Field::HasMany,
    attachments_blobs: Field::HasMany,
    comments: Field::HasMany,
    description: Field::Text,
    resolved_at: Field::DateTime,
    status: Field::BelongsTo,
    ticket_type: Field::BelongsTo,
    title: Field::String,
    unit: Field::BelongsTo,
    user: Field::BelongsTo,
    #versions: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    completed_at: Field::DateTime
    
  }.freeze

 
COLLECTION_ATTRIBUTES = %i[
    id
    title
    unit
    ticket_type
    status
    created_at
    completed_at
  ].freeze
  
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    
    comments
    description
    resolved_at
    status
    ticket_type
    title
    unit
    user
    created_at
    updated_at
    completed_at
  ].freeze

 
  FORM_ATTRIBUTES = %i[
    status
    ticket_type
  ].freeze

  
 
  COLLECTION_FILTERS = {}.freeze

 
end
