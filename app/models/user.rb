class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :lockable, :timeoutable
end
