class TicketsController < ApplicationController

  # Obriga o usuário a estar logado para acessar qualquer coisa aqui
  before_action :authenticate_user!
  
  # Este comando roda a verificação de segurança ANTES de abrir a tela show ou de atualizar
  before_action :set_ticket_and_check_permission, only: [:show, :update]

 def index
    # 1. DEFINIMOS A LISTA BASE E OS BLOCOS DO FILTRO
    if current_user.admin?
      @tickets = Ticket.all
      @filter_blocks = Block.all.order(:name) 
      
    elsif current_user.collaborator?
      @tickets = Ticket.where(ticket_type_id: current_user.assigned_ticket_type_ids)
      @filter_blocks = Block.all.order(:name) 
      
    else
      @tickets = current_user.tickets
      @filter_blocks = Block.where(id: current_user.units.select(:block_id)).order(:name) 
    end

  
    # 2. FILTROS DA BARRA DE BUSCA
   
    if params[:status_id].present?
      @tickets = @tickets.where(status_id: params[:status_id])
    end

    if params[:ticket_type_id].present?
      @tickets = @tickets.where(ticket_type_id: params[:ticket_type_id])
    end

    if params[:block_id].present?
      
      @tickets = @tickets.joins(:unit).where(units: { block_id: params[:block_id] })
    end

    
    @tickets = @tickets.order(created_at: :desc)
  end


  def new
    @ticket = Ticket.new
    set_units_for_form
  end

  def create
    @ticket = Ticket.new(ticket_params)
    
    # Lógica para chamados retroativos/em nome de terceiros
    if current_user.admin? && params[:ticket][:user_id].present?
      @ticket.user_id = params[:ticket][:user_id]
    else
      
      @ticket.user = current_user
    end

    if @ticket.save
      redirect_to @ticket, notice: "Chamado aberto com sucesso!"
    else
      set_units_for_form
      render :new, status: :unprocessable_entity
    end
  end

  def show
    
  end

  def update
    
    
    if current_user.admin? || current_user.collaborator?
    
      if @ticket.update(status_id: params[:ticket][:status_id])
        
        # VERIFICAÇÃO AUTOMÁTICA DE CONCLUSÃO:
        if @ticket.status.is_final?
          @ticket.update_column(:resolved_at, Time.current)
        else
          @ticket.update_column(:resolved_at, nil)
        end
        
        redirect_to @ticket, notice: "Chamado atualizado com sucesso!"
      else
        render :show, status: :unprocessable_entity
      end
    end
  end

  
  private

  def ticket_params
    params.require(:ticket).permit(:unit_id, :ticket_type_id, :user_id, :title, :description, attachments: [])
  end

  def set_units_for_form
    if current_user.admin? || current_user.collaborator?
      # Admin e Colaborador veem todos os apartamentos
      @units = Unit.all.order(:number)
    else
      # Morador só vê as unidades que pertencem a ele
      @units = current_user.units
    end
  end

  
  def set_ticket_and_check_permission
    @ticket = Ticket.find(params[:id])

    if current_user.resident?
      # Se o morador tentar acessar o chamado de outra pessoa, é bloqueado
      unless @ticket.user_id == current_user.id
        redirect_to tickets_path, alert: "Você não tem permissão para ver este chamado."
      end
      
    elsif current_user.collaborator?
      # Se o colaborador tentar acessar um chamado que não é da área dele, e bloqueado
      unless current_user.assigned_ticket_type_ids.include?(@ticket.ticket_type_id)
        redirect_to tickets_path, alert: "Você não tem permissão para acessar este chamado."
      end
    end
    # Se for admin, passa direto sem bloqueios.
  end
end