class Order < ApplicationRecord
  attr_reader :nonce
  include AASM

  has_many :order_items
  belongs_to :user

  before_create :create_order_num #callback

  aasm column: 'state' do # default column: aasm_state
    state :pending, initial: true
    state :paid, :delivered, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
      after_transaction do
        puts "-" * 10
        puts "發送簡訊"
        puts "-" * 10
      end
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end
    event :cancel do
      transitions from: [:pending, :paid], to: :cancelled
    end
  end


  private

  def create_order_num
    self.order_num =  num_generator
  end

  def num_generator
    year = Date.today.year
    month = Date.today.month
    day = Date.today.day
    code = [*0..9,*'A'..'Z'].sample(6).join
    "#{year}#{"%02d" % month}#{"%02d" % day}#{code}"
  end

end
