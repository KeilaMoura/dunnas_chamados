class User < ApplicationRecord
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0, collaborator: 1, resident: 2 }

  has_many :user_units, dependent: :destroy 
  has_many :units, through: :user_units
  has_many :tickets
  has_many :comments, dependent: :destroy
  has_many :user_ticket_types, dependent: :destroy
  has_many :assigned_ticket_types, through: :user_ticket_types, source: :ticket_type

  accepts_nested_attributes_for :user_units, allow_destroy: true
  

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :resident
  end

  def role_translated
  I18n.t("activerecord.enums.user.role.#{role}", default: role)
end





end