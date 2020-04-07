class Event < ApplicationRecord
  has_many :histories
  has_many :event, through: :histories
end
