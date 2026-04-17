
# Popula o banco automaticamente com dados de teste.

puts "🌱 Plantando os dados iniciais..."

# 1. Usuários
admin = User.find_or_create_by!(email: "admin@dunnastecnologia.com.br") do |u|
  u.password = "password123"
  u.name = "Administrador Geral"
  u.cpf = "000.000.000-00"
  u.role = :admin
end

colaborador = User.find_or_create_by!(email: "colaborador@dunnastecnologia.com.br") do |u|
  u.password = "password123"
  u.name = "João Zelador"
  u.cpf = "111.111.111-11"
  u.role = :collaborator
end

morador = User.find_or_create_by!(email: "morador@condominio.com") do |u|
  u.password = "password123"
  u.name = "Maria Moradora"
  u.cpf = "222.222.222-22"
  u.role = :resident
end

# 2. Estrutura do Condomínio
bloco_a = Block.find_or_create_by!(name: "Bloco A") do |b|
  b.total_floors = 5
  b.units_per_floor = 4
end

# 3. Vincular Morador ao Apto 101 do Bloco A
if morador.units.empty?
  UserUnit.create!(user: morador, unit: bloco_a.units.first)
end

# 4. Status
Status.find_or_create_by!(name: "Aberto") { |s| s.is_default = true; s.is_final = false }
Status.find_or_create_by!(name: "Em Andamento") { |s| s.is_default = false; s.is_final = false }
Status.find_or_create_by!(name: "Concluído") { |s| s.is_default = false; s.is_final = true }

# 5. Tipos de Chamado
limpeza = TicketType.find_or_create_by!(title: "Limpeza") { |t| t.sla_hours = 12 }
TicketType.find_or_create_by!(title: "Elétrica") { |t| t.sla_hours = 24 }
TicketType.find_or_create_by!(title: "Encanamento") { |t| t.sla_hours = 48 }
TicketType.find_or_create_by!(title: "Barulho/Infração") { |t| t.sla_hours = 72 }

# 6. Delegar Especialidade ao Colaborador
# O colaborador João Zelador é responsável por chamados de limpeza
UserTicketType.find_or_create_by!(user: colaborador, ticket_type: limpeza)

puts "✅ Dados criados com sucesso!"