class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  has_many_attached :medias # Permite anexar imagens e vídeos


  validate :must_have_content_or_media

  private


  def must_have_content_or_media
    # Se o texto estiver em branco E não tiver NENHUMA mídia anexada...
    if content.blank? && !medias.attached?
      # ...mostra o erro!
      errors.add(:base, "Você precisa digitar uma mensagem ou enviar um anexo.")
    end
  end
end