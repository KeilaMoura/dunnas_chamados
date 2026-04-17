require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String, 
    cpf: Field::String,  
    email: Field::String,
    password: Field::Password,
    
    # Adicionamos o campo de unidades aqui
    units: Field::HasMany.with_options(
      direction: :desc,
      order: "number",
    ),

    role_translated: Field::String.with_options(searchable: false),
    role: Field::Select.with_options(
      searchable: true,
      collection: {
        "Administrador" => "admin",
        "Colaborador" => "collaborator",
        "Morador" => "resident"  
      },
      prompt: "Selecione um cargo"
    ),
    created_at: Field::DateTime.with_options(format: "%d/%m/%Y às %H:%M"),
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    cpf
    email
    role_translated
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    cpf
    email
    role
    units 
    created_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    cpf
    email
    password
    role
    units
  ].freeze

  def display_resource(user)
    user.name
  end
end