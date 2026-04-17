class ApplicationController < ActionController::Base

  # Redireciona o usuário logo após o login
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path # SÓ O ADMIN vai pro painel
    else
      root_path # Colaborador e Morador vão pro App
    end
  end
end