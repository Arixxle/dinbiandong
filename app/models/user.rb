class User < ApplicationRecord
  # attr_accessor :password_confirm

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, 
                       confirmation: true, 
                       length: { minimum: 4 }

  has_many :histories
  has_many :event, through: :histories
end
