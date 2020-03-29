class User < ApplicationRecord
  has_many :account_memberships, class_name: "AccountMember"
  has_many :accounts, through: :account_memberships

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable # , :timeoutable

  validates :name, presence: true
  validates :password_confirmation, presence: true, on: :create
end
