

# 🏢 Dunnas Chamados

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)

## 🎯 Sobre o Projeto e Problema Resolvido

O **Dunnas Chamados** é um sistema de gerenciamento de chamados de manutenção focado na infraestrutura de condomínios e prédios residenciais/comerciais.

**O Problema:** A gestão de manutenções (elétrica, hidráulica, limpeza) em condomínios costuma ser caótica, feita através de grupos de WhatsApp, interfone ou cadernos de papel. Isso resulta em perda de histórico, atrasos no atendimento (SLA) e dificuldade em rastrear qual funcionário é responsável por qual tarefa.

**A Solução:** Um sistema centralizado onde moradores podem abrir chamados vinculados especificamente aos seus apartamentos. O sistema categoriza os pedidos automaticamente, define prazos (SLA) e os atribui aos colaboradores corretos, garantindo transparência, histórico e agilidade para a administração.

---

## 👥 Tipos de Usuários

O sistema possui controle de acesso baseado em três perfis (Roles):

1. 👑 **Administrador Geral (Admin):** Possui acesso irrestrito ao painel. Pode cadastrar condomínios/unidades, criar categorias de chamados (com SLAs), gerenciar a equipe de colaboradores e ter uma visão gerencial de todos os tickets.
2. 🛠️ **Colaborador (Collaborator):** O profissional que executa o serviço (ex: zelador, encanador). Tem acesso restrito para visualizar e atualizar apenas os chamados que pertencem à sua área de atuação.
3. 🏠 **Morador (Resident):** O usuário final. Acessa o sistema apenas para gerenciar as unidades onde mora (pode ter mais de uma) e abrir/acompanhar o status dos seus próprios chamados.

---

## 🏗️ Processo de Desenvolvimento e Decisões Técnicas

* **Ruby on Rails:** Escolhido pela alta produtividade e pelas convenções consolidadas que permitem focar nas regras de negócio.
* **Administrate:** Adotado para a criação acelerada do painel de controle (Back-office). As telas geradas foram customizadas para lidar com escopos específicos.
* **Docker & Docker Compose:** Utilizado para padronizar o ambiente de desenvolvimento. Toda a aplicação e o banco de dados rodam em containers, eliminando a barreira do "na minha máquina funciona" e facilitando o deploy.
* **Testes (RSpec):** Implementação de testes automatizados para garantir a estabilidade das regras de negócio e integridade do banco de dados a cada nova alteração.

---

## ✨ Estrutura e Principais Funcionalidades

* **Gestão de Unidades:** Cadastro estruturado por Blocos, Andares e Números de Apartamentos.
* **Múltiplos Vínculos:** Suporte nativo para que um único morador seja responsável por várias unidades diferentes simultaneamente.
* **Tipos de Chamado (Ticket Types):** Categorização inteligente. Cada tipo de chamado possui um Prazo de Resolução (SLA em horas) próprio e uma equipe de colaboradores restrita àquela especialidade.
* **Acompanhamento de Tickets:** Fluxo de status (Aberto, Em Andamento, Concluído) atualizado em tempo real.

---

## 🔍 Sistema de Filtros e Busca

Para garantir uma gestão eficiente, o sistema conta com filtros inteligentes que permitem listar chamados de acordo com:
* **Categoria:** Filtrar apenas problemas de Elétrica, Hidráulica, Limpeza, etc.
* **Status:** Visualizar rapidamente o que está Aberto, Em Andamento ou Concluído.
* **Localização (Blocos):** Agrupar chamados por blocos específicos do condomínio, facilitando a logística da equipe de manutenção.

---

## 🔄 Fluxo do Sistema (Ciclo de Vida do Chamado)

1. **Vínculo e Contexto:** O sistema identifica quais unidades estão vinculadas ao **Morador**. Ao abrir um chamado, o morador seleciona a unidade específica do problema.
2. **Abertura e Especialidade:** O morador escolhe a categoria (ex: Elétrica). O sistema inicia automaticamente a contagem do **SLA (prazo)** definido para aquele tipo.
3. **Triagem e Visibilidade:** O chamado aparece no dashboard apenas dos **Colaboradores** com a especialidade compatível. O **Administrador** acompanha todo o processo globalmente.
4. **Gestão e Interação:** Colaborador, Morador e Admin utilizam os **Comentários** (que permitem textos e imagens) para comunicação oficial e registro auditável.
5. **Conclusão:** Após o serviço, o chamado é marcado como **Concluído**. Ele permanece listado no sistema para consulta histórica com o status atualizado.
6. **Manutenção da Base:** Caso necessário, o **Administrador** tem a permissão exclusiva para remover chamados concluídos da listagem oficial.

---

## 🗄️ Diagrama Relacional do Banco de Dados

<img width="1833" height="1766" alt="Untitled (1)" src="https://github.com/user-attachments/assets/ad024470-a052-4a2b-8dc4-c00cfe499a4a" />


---

## 🚀 Instruções de Execução (Docker)

📌 **Pré-requisitos**
Certifique-se de ter instalado em sua máquina:
* Git
* Docker e Docker Compose

🛠️ **Passo a Passo**

**1. Clone o repositório:**
```bash
git clone https://github.com/KeilaMoura/dunnas_chamados.git
cd dunnas_chamados
```

**2. Construa a imagem da aplicação (Build):**
```bash
docker compose build
```

**3. Inicie a infraestrutura em background:**
*Graças ao script de Entrypoint, o banco de dados será criado e as migrações serão executadas automaticamente.*
```bash
docker compose up -d
```

**4. Popule o Banco de Dados (Seeds):**
*Para popular o sistema recém-criado com os dados iniciais de teste, execute:*
```bash
docker compose exec web rails db:seed
```

### ⚠️ Solução de Problemas (Troubleshooting)

Se o comando de `seed` falhar, ou se você testou o sistema e deseja **resetar o banco de dados** para o estado original de fábrica (apagando todos os chamados de teste criados), utilize o comando de reset completo:

```bash
docker compose run --rm web rails db:drop db:create db:migrate db:seed
```

**5. Acesse a aplicação:**
Abra seu navegador em: `http://localhost:3000`

---

## 🔐 Credenciais Iniciais

Após rodar o comando de `seed` no passo anterior, o banco de dados será populado com os acessos abaixo:

| Perfil | E-mail | Senha Padrão |
| :--- | :--- | :--- |
| **Admin** | `admin@dunnastecnologia.com.br` | `password123` |
| **Colaborador** | `colaborador@dunnastecnologia.com.br` | `password123` |
| **Morador** | `morador@condominio.com` | `password123` |

---

## ⚙️ Arquitetura DevOps: 

Para garantir uma **Experiência Zero Fricção** para quem clona o repositório, o projeto conta com um script de inicialização automatizado (`entrypoint.sh`).

Em sistemas web tradicionais, o desenvolvedor precisa lembrar de rodar comandos de atualização de banco de dados sempre que baixa uma nova versão do código. Neste projeto, eliminamos essa necessidade de intervenção humana.

**Como funciona o ciclo de vida do container:** Sempre que o comando `docker compose up` é acionado, o fluxo a seguir ocorre de forma 100% invisível ao usuário:

* **Limpeza de PID:** O script deleta possíveis arquivos `server.pid` remanescentes de desligamentos abruptos, prevenindo travamentos de inicialização do Puma (servidor web).
* **Auto-Migração (`db:prepare`):** O script interroga o banco de dados PostgreSQL. Se o banco não existir, ele o cria. Se houver novas migrations pendentes no código, ele as executa automaticamente.
* **Passagem de Bastão:** Apenas após a infraestrutura confirmar que o banco está sincronizado com o código, o script passa o controle para o processo principal (Rails Server), liberando o acesso na porta 3000.

Isso garante que o comando `docker compose up` seja a única coisa que o usuário ou a esteira de CI/CD precisa saber para rodar a aplicação em seu estado mais atual.

---

## ✅ Atendimento aos Requisitos e Boas Práticas (Checklist)

* **Versionamento de Banco:** Todas as alterações estruturais foram feitas via Migrations, permitindo a recriação consistente do banco em qualquer ambiente.
* **SLA e Auditoria:** O sistema calcula automaticamente o tempo de resolução (`resolved_at`) e mantém o histórico de interações via comentários, fechando o ciclo de vida real de um chamado com total rastreabilidade.
* **Sistema de Filtros Avançados:** Buscas por status, categoria e bloco, essencial para escalar a operação de um condomínio grande.
* **Comunicação Rica (Comentários e Anexos):** Troca de mensagens direta no chamado com suporte a imagens, eliminando a necessidade de comunicação externa (WhatsApp) e centralizando as evidências do problema e da resolução.

---

## 🧪 Testes Automatizados

O projeto conta com testes automatizados utilizando RSpec. Para garantir que tudo está funcionando, execute a suíte de testes:

```bash
docker compose run --rm web bundle exec rspec
```

**Troubleshooting de Testes:**
Se o Rails acusar o erro `ActiveRecord::EnvironmentMismatchError` (indicando conflito entre o banco de desenvolvimento e o de testes), repare o ambiente executando:
```bash
docker compose run --rm web rails db:environment:set RAILS_ENV=test
docker compose run --rm web rails db:test:prepare
```
```
