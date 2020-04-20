class User < ApplicationRecord
  # attr_accessor :password_confirm

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, 
                       confirmation: true, 
                       length: { minimum: 4 }

  #relationship
  has_many :histories
  has_many :event, through: :histories
  has_many :comments
end
