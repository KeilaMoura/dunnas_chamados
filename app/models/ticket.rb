class Ticket < ApplicationRecord
  has_paper_trail 
  
  belongs_to :user
  belongs_to :unit
  belongs_to :ticket_type
  belongs_to :status

  has_many_attached :attachments
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true

  before_validation :set_default_status, on: :create

 
  before_save :manage_completion_date, if: :status_id_changed?

  private

  def set_default_status
    self.status ||= Status.find_by(is_default: true)
  end

  
  def manage_completion_date
    if status&.name == "Concluído"
      self.completed_at = Time.current
    else
      self.completed_at = nil
    end
  end
end