class User < ApplicationRecord
  has_many :account_memberships, class_name: "AccountMember"
  has_many :accounts, through: :account_memberships

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable

  validates :name, presence: true
  validates :password_confirmation, presence: true, on: :create

  def is_account_owner?(account)
    is_account_member_kind?(account, :owner)
  end

  def is_account_admin?(account)
    is_account_member_kind?(account, :admin)
  end

  def is_account_member_kind?(account, kind)
    account_memberships
      .joins(:role, :account)
      .where(account_roles: {slug: kind.to_s.downcase})
      .where(accounts: {id: account.id})
      .any?
  end
end
