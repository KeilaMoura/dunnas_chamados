# O módulo Admin agrupa controladores que pertencem ao painel administrativo


module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    private

    def require_admin
      unless current_user.admin?
        redirect_to '/', alert: "Acesso restrito apenas para administradores."
      end
    end
  end
end