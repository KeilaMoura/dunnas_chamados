
# Dunnas Chamados - Sistema de Gerenciamento de Chamados para Condomínio

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)

## Sumário

* [Sobre o Projeto e Problema Resolvido](#sobre-o-projeto-e-problema-resolvido)
* [Tipos de Usuários](#tipos-de-usuários)
* [Processo de Desenvolvimento e Decisões Técnicas](#processo-de-desenvolvimento-e-decisões-técnicas)
* [Gems e Dependências Principais](#gems-e-dependências-principais)
* [Estrutura e Principais Funcionalidades](#estrutura-e-principais-funcionalidades)
* [Sistema de Filtros e Busca](#sistema-de-filtros-e-busca)
* [Fluxo do Sistema (Ciclo de Vida do Chamado)](#fluxo-do-sistema-ciclo-de-vida-do-chamado)
* [Diagrama e Relacionamentos do Banco de Dados](#diagrama-e-relacionamentos-do-banco-de-dados)
* [Resumo dos Relacionamentos do Banco de Dados](#resumo-dos-relacionamentos)
* [Extras e Diferenciais Implementados](#extras-e-diferenciais-implementados)
* [Instruções de Execução (Docker)](#instruções-de-execução-docker)
* [Credenciais Iniciais](#credenciais-iniciais)
* [Arquitetura DevOps](#arquitetura-devops)
* [Atendimento aos Requisitos e Boas Práticas](#atendimento-aos-requisitos-e-boas-práticas)
* [Testes Automatizados (RSpec)](#testes-automatizados-rspec)

---

## Sobre o Projeto e Problema Resolvido

O **Dunnas Chamados** é um sistema de gerenciamento de chamados de manutenção focado na infraestrutura de condomínios e prédios residenciais/comerciais.

**O Problema:** A gestão de manutenções (elétrica, hidráulica, limpeza) em condomínios costuma ser caótica, feita através de grupos de WhatsApp, interfone ou cadernos de papel. Isso resulta em perda de histórico, atrasos no atendimento (SLA) e dificuldade em rastrear qual funcionário é responsável por qual tarefa.

**A Solução:** Um sistema centralizado onde moradores podem abrir chamados vinculados especificamente aos seus apartamentos. O sistema categoriza os pedidos automaticamente, define prazos (SLA) e os atribui aos colaboradores corretos, garantindo transparência, histórico e agilidade para a administração.

---

## Tipos de Usuários

O sistema possui controle de acesso baseado em três perfis (Roles):

1. **Administrador Geral (Admin):** Possui acesso irrestrito ao painel. Pode cadastrar condomínios/unidades, criar categorias de chamados (com SLAs), gerenciar a equipe de colaboradores e ter uma visão gerencial de todos os tickets.
2. **Colaborador (Collaborator):** O profissional que executa o serviço (ex: zelador, encanador). Tem acesso restrito para visualizar e atualizar apenas os chamados que pertencem à sua área de atuação.
3. **Morador (Resident):** O usuário final. Acessa o sistema apenas para gerenciar as unidades onde mora (pode ter mais de uma) e abrir/acompanhar o status dos seus próprios chamados.

---

## Processo de Desenvolvimento e Decisões Técnicas

* **Ruby on Rails 7.1 (MVC):** Escolhido pela alta produtividade e pelas convenções consolidadas que permitem focar nas regras de negócio e integrações de banco de dados nativas (Active Record).
* **Autenticação (Devise):** Utilizado para garantir um controle de sessão seguro e robusto, padrão da indústria Rails.
* **Auditoria de Dados (PaperTrail):** Em vez de criar lógicas manuais, optei por utilizar a gem `paper_trail`, o padrão de mercado para rastreamento de alterações, garantindo um log de auditoria seguro e confiável de todas as mudanças de status dos chamados.
* **Internacionalização (I18n):** Sistema totalmente localizado para Português (pt-BR), incluindo validações e mensagens do Devise, garantindo uma experiência de uso natural.
* **Administrate:** Adotado para a criação acelerada do painel de controle (Back-office). As telas geradas foram customizadas para lidar com escopos e filtros específicos de gestão.
* **Docker & Docker Compose:** Utilizado para padronizar o ambiente de desenvolvimento. Toda a aplicação e o banco de dados rodam em containers, eliminando a barreira do "na minha máquina funciona".

---

## Gems e Dependências Principais

| Gem | Finalidade |
| :--- | :--- |
| `rails` (~> 7.1.6) | Framework backend principal (MVC). |
| `pg` | Adaptador para o banco de dados PostgreSQL. |
| `devise` | Gestão de autenticação e segurança de usuários. |
| `paper_trail` | Versionamento de registros e trilha de auditoria (Histórico). |
| `administrate` | Geração customizável do painel administrativo. |
| `rspec-rails` | Framework de testes automatizados (TDD/BDD). |
| `turbo-rails` / `stimulus` | Stack Hotwire para navegação rápida e interatividade SPA-like. |
| `rails-i18n` | Traduções oficiais e localização para pt-BR. |

---

## Estrutura e Principais Funcionalidades

* **Gestão de Unidades:** Cadastro estruturado por Blocos, Andares e Números de Apartamentos.
* **Múltiplos Vínculos:** Suporte nativo para que um único morador seja responsável por várias unidades diferentes simultaneamente.
* **Tipos de Chamado (Ticket Types):** Categorização inteligente. Cada tipo de chamado possui um Prazo de Resolução (SLA em horas) próprio e uma equipe de colaboradores restrita àquela especialidade.
* **Gestão de Usuários Localizada:** Cadastro de perfis preparado para o cenário brasileiro, exigindo documentação real (`cpf`) para fins de auditoria e segurança condominial.
* **Acompanhamento de Tickets:** Fluxo de status (Aberto, Em Andamento, Concluído) atualizado em tempo real.

---

## Sistema de Filtros e Busca

Para garantir uma gestão eficiente, o sistema conta com filtros inteligentes que permitem listar chamados de acordo com:
* **Categoria:** Filtrar apenas problemas de Elétrica, Hidráulica, Limpeza, etc.
* **Status:** Visualizar rapidamente o que está Aberto, Em Andamento ou Concluído.
* **Localização (Blocos):** Agrupar chamados por blocos específicos do condomínio, facilitando a logística da equipe de manutenção.

---

## Fluxo do Sistema (Ciclo de Vida do Chamado)

1. **Vínculo e Contexto:** O sistema identifica quais unidades estão vinculadas ao **Morador**. Ao abrir um chamado, o morador seleciona a unidade específica do problema.
2. **Abertura e Especialidade:** O morador escolhe a categoria (ex: Elétrica). O sistema inicia automaticamente a contagem do **SLA (prazo)** definido para aquele tipo.
3. **Triagem e Visibilidade:** O chamado aparece no dashboard apenas dos **Colaboradores** com a especialidade compatível. O **Administrador** acompanha todo o processo globalmente.
4. **Gestão e Interação:** Colaborador, Morador e Admin utilizam os **Comentários** (que permitem textos e imagens) para comunicação oficial e registro auditável.
5. **Conclusão:** Após o serviço, o chamado é marcado como **Concluído**. Ele permanece listado no sistema para consulta histórica com o status atualizado e registra o tempo exato de finalização.
6. **Manutenção da Base:** Caso necessário, o **Administrador** tem a permissão exclusiva para remover chamados concluídos da listagem oficial.

---

## Diagrama e Relacionamentos do Banco de Dados

<img width="1845" height="1766" alt="Untitled (9)" src="https://github.com/user-attachments/assets/e465ea85-f0fa-4d48-8684-e9f952b38caf" />


* Link para visualização: https://dbdiagram.io/d/69e8df3ad80a958d1cb0ab2d

### Resumo dos Relacionamentos 

| Relacionamento | Tipo | Via |
| :--- | :--- | :--- |
| `Block` → `Unit` | 1:N | `block_id` em `units` |
| `User` ↔ `Unit` (moradores) | N:N | tabela `user_units` |
| `User` ↔ `TicketType` (colaboradores) | N:N | tabela `user_ticket_types` |
| `Ticket` → `Unit` | N:1 | `unit_id` em `tickets` |
| `Ticket` → `User` (autor) | N:1 | `user_id` em `tickets` |
| `Ticket` → `TicketType` | N:1 | `ticket_type_id` em `tickets` |
| `Ticket` → `Status` | N:1 | `status_id` em `tickets` |
| `Ticket` → `Comment` | 1:N | `ticket_id` em `comments` |
| `Ticket` → Histórico (Auditoria) | 1:N | `item_id` em `versions` (PaperTrail) |
| `Ticket` → Anexos | 1:N | Active Storage (`active_storage_attachments`) |

---

## Extras e Diferenciais Implementados

Para ir além dos requisitos básicos do desafio e entregar uma solução com maturidade de mercado, os seguintes diferenciais foram implementados:

* **Arquitetura Avançada (Service Objects):** Isolamento de regras de negócio complexas fora do padrão MVC comum (como a lógica de geração de unidades do condomínio), mantendo os *Models* e *Controllers* limpos e fáceis de testar.
* **Auditoria de Ações do Sistema:** Implementação de trilha de auditoria avançada (via gem `paper_trail`). O sistema registra de forma imutável todo o histórico de alterações, horários e usuários responsáveis, garantindo total rastreabilidade (compliance).
* **Máquina de Status Dinâmica:** Os status dos chamados não são fixos no código. Eles possuem os atributos `is_default` (status de nascimento) e `is_final` (status de encerramento de SLA), permitindo escalabilidade na criação de novos fluxos de atendimento.
* **Uploads Cloud-Ready (Active Storage):** Gerenciamento de anexos e evidências de forma nativa, permitindo que os arquivos sejam facilmente migrados para serviços de nuvem (como AWS S3) em produção.
* **Integridade de Dados Blindada:** Relacionamentos N:N complexos (Morador ↔ Unidades e Técnico ↔ Especialidades) garantidos por *Foreign Keys* no nível do banco de dados (PostgreSQL), prevenindo registros órfãos.
* **Setup Local "Zero Fricção":** Automação completa do ambiente com Docker. O projeto inteiro sobe, cria o banco, migra e popula os dados apenas com `docker compose up`.

---

## Instruções de Execução (Docker)

**Pré-requisitos**
Certifique-se de ter instalado em sua máquina:
* Git
* Docker e Docker Compose

**Passo a Passo**

**1. Clone o repositório:**
```bash
git clone https://github.com/KeilaMoura/dunnas_chamados.git
cd dunnas_chamados
````

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

> **O que o `db:seed` prepara para o teste?**
> Para facilitar a avaliação, o script de seed monta um cenário real e interligado:
>
>   * **Infraestrutura Automatizada:** Cria o "Bloco A" gerando automaticamente suas 20 unidades (5 andares x 4 apartamentos).
>   * **Categorias e SLAs:** Cadastra 4 tipos de chamados com prazos específicos: Limpeza (12h), Elétrica (24h), Encanamento (48h) e Barulho/Infração (72h).
>   * **Fluxo de Status:** Prepara a máquina de estados: *Aberto* (Padrão) ➔ *Em Andamento* ➔ *Concluído* (Final).
>   * **Contexto de Teste:** Cria a "Maria Moradora" já vinculada ao Apto 101, pronta para abrir chamados.
>   * **Triagem na Prática:** Cria o "João Zelador" (Colaborador) e o **vincula exclusivamente à especialidade de Limpeza**, demonstrando o controle de escopo (ele não verá chamados de elétrica, por exemplo).

### Solução de Problemas

Se o comando de `seed` falhar, ou se testou o sistema e deseja **resetar o banco de dados** para o estado original de fábrica (apagando todos os chamados de teste criados), utilize o comando de reset completo:

```bash
docker compose run --rm web rails db:drop db:create db:migrate db:seed
```

**5. Acesse a aplicação:**
Abra o seu navegador em: `http://localhost:3000`

-----

## Credenciais Iniciais

Após rodar o comando de `seed` no passo anterior, o banco de dados será populado com os acessos abaixo:

| Perfil | E-mail | Senha Padrão |
| :--- | :--- | :--- |
| **Admin** | `admin@dunnastecnologia.com.br` | `password123` |
| **Colaborador** | `colaborador@dunnastecnologia.com.br` | `password123` |
| **Morador** | `morador@condominio.com` | `password123` |

-----

## Arquitetura DevOps

Para garantir uma **Experiência Zero Fricção** para quem clona o repositório, o projeto conta com um script de inicialização automatizado (`entrypoint.sh`).

Em sistemas web tradicionais, o desenvolvedor precisa lembrar de rodar comandos de atualização de banco de dados sempre que baixa uma nova versão do código. Neste projeto, eliminamos essa necessidade de intervenção humana.

**Como funciona o ciclo de vida do container:** Sempre que o comando `docker compose up` é acionado, o fluxo a seguir ocorre de forma 100% invisível ao utilizador:

  * **Limpeza de PID:** O script apaga possíveis arquivos `server.pid` remanescentes de desligamentos abruptos, prevenindo travamentos de inicialização do Puma (servidor web).
  * **Auto-Migração (`db:prepare`):** O script interroga o banco de dados PostgreSQL. Se o banco não existir, ele cria. Se houver novas migrations pendentes no código, executa-as automaticamente.
  * **Passagem de Bastão:** Apenas após a infraestrutura confirmar que o banco está sincronizado com o código, o script passa o controlo para o processo principal (Rails Server), libertando o acesso na porta 3000.

-----

## Atendimento aos Requisitos e Boas Práticas

  * **Auditoria Robusta (PaperTrail):** Diferente de implementações manuais propensas a falhas, o uso do PaperTrail garante que toda a mudança de status, utilizador responsável e horário da alteração fique salva na base de dados de forma imutável, permitindo rastreabilidade total (compliance).
  * **Versionamento de Banco:** Todas as alterações estruturais foram feitas via Migrations, permitindo a recriação consistente do banco em qualquer ambiente.
  * **SLA Automático:** O sistema calcula automaticamente o tempo de resolução (`resolved_at`) fechando o ciclo de vida real de um chamado.
  * **Sistema de Filtros Avançados:** Buscas por status, categoria e bloco, essencial para escalar a operação de um condomínio grande.
  * **Comunicação Rica (Comentários e Anexos):** Troca de mensagens direta no chamado com suporte a imagens, eliminando a necessidade de comunicação externa (WhatsApp) e centralizando as evidências do problema e da resolução.

-----

## Testes Automatizados (RSpec)

O projeto utiliza a gem **RSpec** com foco em validar as regras de negócio mais críticas e complexas da aplicação, isolando as responsabilidades de acordo com as boas práticas da comunidade.

**Onde os testes estão implementados?**
A estrutura está dividida dentro do diretório `spec/`:

  * `spec/models/`: Testes unitários para garantir a integridade dos dados e regras básicas.
  * `spec/services/`: Testes focados em regras de negócio isoladas (*Service Objects*).

**O que exatamente está sendo testado?**

| Arquivo de Teste | O que a suíte valida na prática |
| :--- | :--- |
| `ticket_spec.rb`<br>*(Coração do Sistema)* | **1. Automação de Nascimento:** Garante o funcionamento do *callback* de criação. O teste tenta criar um chamado sem status, e o sistema deve ser inteligente o suficiente para buscar no banco e injetar automaticamente o status configurado como `is_default: true` (ex: "Aberto").<br><br>**2. Automação de SLA/Encerramento:** Testa a imutabilidade temporal. O teste cria um chamado, verifica que a data de conclusão está em branco e, em seguida, altera o chamado para um status do tipo `is_final: true` (ex: "Concluído"). O sistema deve obrigatoriamente "carimbar" o campo `completed_at` com o horário exato da ação, fechando o ciclo de SLA. |
| `generate_units_spec.rb`<br>*(Service Object)* | Testa a lógica do gerador automático de unidades. O robô cria um Bloco com uma regra (ex: 5 andares, 4 apartamentos por andar) e valida se o banco de dados gerou exatamente 20 unidades com as numerações e vínculos matematicamente corretos (ex: 101, 102... 504). |

Para executar a suíte de testes e conferir as validações, utilize:

```bash
docker compose run --rm web bundle exec rspec
```

**Troubleshooting de Testes:**
Se o Rails acusar o erro `ActiveRecord::EnvironmentMismatchError` (indicando conflito entre o banco de desenvolvimento e o de testes), repare o ambiente executando:

```bash
docker compose run --rm web rails db:environment:set RAILS_ENV=test
docker compose run --rm web rails db:test:prepare
```


