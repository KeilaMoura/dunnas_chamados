class TicketType < ApplicationRecord
  has_many :tickets
  has_many :user_ticket_types, dependent: :destroy
  has_many :users, through: :user_ticket_types
  validates :title, :sla_hours, presence: true


  def responsaveis_nomes
    if users.any?
      # Pega o nome (ou email, se não tiver nome) e junta com vírgula
      users.map { |u| u.name.presence || u.email }.join(', ')
    else
      "Sem responsável"
    end
  end
end