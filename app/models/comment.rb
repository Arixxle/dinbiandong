class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 2 }
  belongs_to :user
  belongs_to :item
  default_scope { where(deleted_at: nil).order(id: :desc)}
end
