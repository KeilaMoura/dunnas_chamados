module Admin
  class TicketTypesController < Admin::ApplicationController
    
   # Método customizado para remover o vínculo entre um Colaborador e um Tipo de Ticket.
    def remove_user
      ticket_type = TicketType.find(params[:id])
      user = User.find(params[:user_id])
      
      # Remove o usuário da coleção de 'users' deste ticket_type.
      ticket_type.users.delete(user)
      
      redirect_to admin_ticket_type_path(ticket_type), notice: "Colaborador desvinculado com sucesso!"
    end

  end
end