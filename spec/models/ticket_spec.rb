require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:all) do
    Ticket.destroy_all
    Status.destroy_all
    TicketType.destroy_all
    Unit.destroy_all
    Block.destroy_all
    User.destroy_all
  end

  describe "Regras de Negocio e Automações" do
    let(:bloco) { Block.create!(name: "Bloco A", total_floors: 5, units_per_floor: 4) }
    let(:unidade) { Unit.create!(number: "101", floor: "1", block: bloco) }
    let(:morador) { User.create!(name: "João", email: "joao@teste.com", password: "password123", role: :resident, cpf: "11122233344") }
    let(:tipo_chamado) { TicketType.create!(title: "Geral", sla_hours: 24) }
    
    let!(:status_padrao) { Status.create!(name: "Aberto", is_default: true, is_final: false) }
    let!(:status_concluido) { Status.create!(name: "Concluído", is_default: false, is_final: true) }

    it "garante que todo chamado nasça com o status marcado como padrão" do
      chamado = Ticket.create!(
        title: "Lâmpada queimada",
        description: "Corredor escuro",
        user: morador,
        unit: unidade,
        ticket_type: tipo_chamado
      )
      
      expect(chamado.status).to eq(status_padrao)
    end

    it "preenche a data de completed_at automaticamente quando o status muda para Concluído" do
      chamado = Ticket.create!(
        title: "Vazamento",
        description: "Pia pingando",
        user: morador,
        unit: unidade,
        ticket_type: tipo_chamado,
        status: status_padrao
      )

      # Antes de concluir, a data deve ser nula
      expect(chamado.completed_at).to be_nil

      # Mudando para o status que dispara o gatilho no seu Model
      chamado.update!(status: status_concluido)

      # Agora o campo que você criou (completed_at) não deve ser nulo
      expect(chamado.completed_at).not_to be_nil
    end
  end
end