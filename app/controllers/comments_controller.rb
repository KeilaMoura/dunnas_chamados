class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    # Verificação de segurança
    if current_user.resident? && @ticket.user != current_user
      redirect_to tickets_path, alert: "Você não pode comentar neste chamado."
      return
    end

    if @comment.save
      redirect_to @ticket, notice: "Comentário adicionado com sucesso!"
    else
     
      redirect_to @ticket, alert: "Erro: #{@comment.errors.full_messages.to_sentence}"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, medias: [])
  end
end