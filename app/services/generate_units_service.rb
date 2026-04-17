class GenerateUnitsService
  def initialize(block)
    @block = block
  end

  def call
    # Se o bloco tem 5 andares e 4 aptos por andar
    (1..@block.total_floors).each do |floor|
      (1..@block.units_per_floor).each do |unit_number|
        
        # Gera o número do apartamento. Ex: Andar 1, Apto 2 -> "102"
        formatted_number = "#{floor}#{format('%02d', unit_number)}"
        
        Unit.create!(
          block: @block,
          floor: floor,
          number: formatted_number
        )
      end
    end
  end
end