

    Rails.application.routes.draw do
      namespace :admin do
        # Define a página inicial do Admin
        root to: "users#index"

        resources :users
        resources :blocks
        
        # Unidades
        resources :units, except: [:new, :create, :destroy] 
        
        # TICKETS DO ADMIN, tela exclusiva com campos retroativos
        resources :tickets, except: [:destroy]

        # Configuração de Tipos de Chamado e Remoção de Responsáveis
        resources :ticket_types do
          member do
            delete 'remove_user/:user_id', to: 'ticket_types#remove_user', as: :remove_user
          end
        end 
        
        # Gestão de Status
        resources :statuses
      end
      
      resources :statuses

      # Autenticação
      devise_for :users

      
      # Tela inicial do sistema (Visão do Morador/Colaborador)
      root "tickets#index" 
      
      # Chamados na interface principal
      resources :tickets, only: [:index, :new, :create, :show, :update] do
        resources :comments, only: [:create]
      end
    end