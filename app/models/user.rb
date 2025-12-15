class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Track all changes for audit trail
  has_paper_trail

  has_many :projects, dependent: :destroy
  has_many :sessions, dependent: :destroy

  # Scopes
  scope :admins, -> { where(admin: true) }
  scope :regular_users, -> { where(admin: false) }

  # Instance methods
  def admin?
    admin
  end
end
