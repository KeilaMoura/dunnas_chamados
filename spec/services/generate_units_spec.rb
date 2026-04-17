require 'rails_helper'

RSpec.describe GenerateUnitsService, type: :service do
  describe "Geração automática de apartamentos" do
    it "gera a quantidade correta de unidades com a numeração padrão" do
      # Cria um bloco de 2 andares com 2 apartamentos por andar
      bloco = Block.create!(name: "Bloco Teste", total_floors: 2, units_per_floor: 2)

      # A expectativa é que o sistema tenha criado 4 apartamentos automaticamente
      expect(bloco.units.count).to eq(4)

      # Verifica se o primeiro é o 101 e o último é o 202
      expect(bloco.units.first.number).to eq("101")
      expect(bloco.units.last.number).to eq("202")
    end
  end
end