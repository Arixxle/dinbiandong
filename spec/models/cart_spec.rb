require 'rails_helper'

RSpec.describe Cart, type: :model do
  # pending "你還沒做任何功能"
  describe "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      cart = Cart.new
      cart.add_item(1)
      expect(cart.empty?).to be false
    end

    it "加相同種類商品，購買項目不會增加，但商品數量會改變。" do
      cart = Cart.new
      
      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }
      2.times { cart.add_item(1) }
      TODO:
      expect(cart.items.count).to be 2
      
    end
  end
  describe "進階功能" do
  end
end
