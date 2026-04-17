


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

1.  **Vínculo e Contexto:** O sistema identifica quais unidades estão vinculadas ao **Morador**. Ao abrir um chamado, o morador seleciona a unidade específica do problema.
2.  **Abertura e Especialidade:** O morador escolhe a categoria (ex: Elétrica). O sistema inicia automaticamente a contagem do **SLA (prazo)** definido para aquele tipo.
3.  **Triagem e Visibilidade:** O chamado aparece no dashboard apenas dos **Colaboradores** com a especialidade compatível. O **Administrador** acompanha todo o processo globalmente.
4.  **Gestão e Interação:** Colaborador, Morador e Admin utilizam os **Comentários** que permitem textos e imagens para comunicação oficial e registro auditável.
5.  **Conclusão:** Após o serviço, o chamado é marcado como **Concluído**. Ele permanece listado no sistema para consulta histórica com o status atualizado.
6.  **Manutenção da Base:** Caso necessário, o **Administrador** tem a permissão exclusiva para remover chamados concluídos da listagem oficial.

---


## 🗄️ Diagrama Relacional do Banco de Dados

<img width="1833" height="1766" alt="Untitled (1)" src="https://github.com/user-attachments/assets/34220afc-aad9-4c40-8134-970058e36e60" />


## 🚀 Instruções de Execução (Docker)

Siga os passos abaixo para rodar o projeto em qualquer ambiente. É necessário ter apenas o Docker e o Docker Compose instalados.

**1. Clone o repositório:**
```bash
git clone https://github.com/KeilaMoura/dunnas_chamados.git
cd dunnas_chamados
```

**2. Construa a imagem da aplicação (Build):**
```bash
docker compose build
```

**3. Inicie os containers (Execução em background):**
```bash
docker compose up -d
```

**4. Prepare o Banco de Dados (Criação, Migrações e Seeds):**
```bash
docker compose run --rm web rails db:drop db:create db:migrate db:seed
```

**5. Acesse a aplicação:**
Abra seu navegador em: `http://localhost:3000`

---

## 🔐 Credenciais Iniciais

Após rodar o comando de `seed` no passo anterior, o banco de dados será populado com dados iniciais para testes.

| Perfil | E-mail | Senha Padrão |
| :--- | :--- | :--- |
| **Admin** | `admin@dunnastecnologia.com.br` | `password123` |
| **Colaborador** | `colaborador@dunnastecnologia.com.br` | `password123` |
| **Morador** | `morador@condominio.com` | `password123` |

*

---

## 🧪 Testes Automatizados

O projeto conta com testes automatizados utilizando RSpec. Para garantir que tudo está funcionando, execute a suíte de testes:

```bash
docker compose run --rm web bundle exec rspec
```

**Troubleshooting de Testes:**
Se o Rails acusar o erro `ActiveRecord::EnvironmentMismatchError` (indicando conflito entre o banco de desenvolvimento e testes), repare o ambiente executando:
```bash
docker compose run --rm web rails db:environment:set RAILS_ENV=test
docker compose run --rm web rails db:test:prepare
```
```
