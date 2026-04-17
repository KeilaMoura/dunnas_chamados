# Controlador responsável pela gestão de Chamados (Tickets) no painel administrativo.

module Admin
  class TicketsController < Admin::ApplicationController
    def new
      @ticket = Ticket.new
      @users = User.all
      @units = Unit.all
      
      
      render "tickets/new" 
    end

    def create
      @ticket = Ticket.new(ticket_params)
      
      if @ticket.save
        redirect_to admin_ticket_path(@ticket), notice: "Chamado criado com sucesso!"
      else
        
        render "tickets/new"
      end
    end

    # Permite que o administrador filtre tickets por Status, Tipo ou Bloco
    def scoped_resource
     
      resource = super
      
      
      resource = resource.where(status_id: params[:status_id]) if params[:status_id].present?
      resource = resource.where(ticket_type_id: params[:ticket_type_id]) if params[:ticket_type_id].present?
      
      if params[:block_id].present?
        resource = resource.joins(:unit).where(units: { block_id: params[:block_id] })
      end
      
      resource
    end
  end

    private

    def ticket_params
      
      params.require(:ticket).permit(:title, :description, :user_id, :unit_id, :ticket_type_id, :status_id, :created_at)
    end
  end
