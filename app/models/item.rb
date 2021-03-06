class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0} 

  belongs_to :category
  has_one_attached :cover
  has_many :comments
  has_many :favorite_items
  has_many :users, through: :favorite_items
  # scope :available, ->{ where(deleted_at: nil)} # 會定義出一個.available類別方法

  default_scope { where(deleted_at: nil) }
  
  def destroy
    update(deleted_at: Time.now)
  end

  def favorite_by(u)
    u.items.include?(self)
  end

end
