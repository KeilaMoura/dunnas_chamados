require "administrate/base_dashboard"

class TicketTypeDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    title: Field::String,
    sla_hours: Field::Number,
    responsaveis_nomes: Field::String,
    # Este campo faz o vínculo com os colaboradores
    users: Field::HasMany.with_options(
      class_name: "User",
      # Filtra para mostrar apenas Admins e Colaboradores na hora de cadastrar
      query: ->(resources) { resources.where(role: ['admin', 'collaborator']) }
    ),
    
    created_at: Field::DateTime.with_options(format: "%d/%m/%Y às %H:%M"),
    updated_at: Field::DateTime,
  }.freeze

 
  COLLECTION_ATTRIBUTES = %i[
    title
    sla_hours
    responsaveis_nomes
    created_at
  ].freeze


  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    sla_hours
    users
    created_at
  ].freeze


  FORM_ATTRIBUTES = %i[
    title
    sla_hours
    users
  ].freeze

  def display_resource(ticket_type)
    ticket_type.title
  end
end