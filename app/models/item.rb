class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0} 

  belongs_to :category
  has_one_attached :cover
  has_many :comments
  # scope :available, ->{ where(deleted_at: nil)} # 會定義出一個.available類別方法

  default_scope { where(deleted_at: nil) }
  
  def destroy
    update(deleted_at: Time.now)
  end
end
