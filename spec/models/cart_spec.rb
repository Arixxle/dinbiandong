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
      expect(cart.items.count).to be 2
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      cart = Cart.new

      # cat1 = FactoryBot.create(:category)
      i1 = FactoryBot.create(:item)
      i2 = FactoryBot.create(:item)
      
      3.times { cart.add_item(i1.id) }
      2.times { cart.add_item(i2.id) }

      expect(cart.items.first.item).to be_an Item 
      expect(cart.items.first.item.price).to be i1.price
    end

    it "可以計算整台購物車的總消費金額。" do
      cart = Cart.new
      i1 = FactoryBot.create(:item, price: 50)
      i2 = FactoryBot.create(:item, price: 100)

      3.times { cart.add_item(i1.id)}
      2.times { cart.add_item(i2.id)}

      expect(cart.total).to be 350
    end

    it "特別活動可搭配折扣" do
      
      cart = Cart.new
      i1 = FactoryBot.create(:item, price: 50)
      i2 = FactoryBot.create(:item, price: 100)

      3.times { cart.add_item(i1.id)}
      2.times { cart.add_item(i2.id)}

      t = Time.local(2008, 4, 1, 10, 5, 0)
      Timecop.travel(t)
      #將事件發生時間移動到4/1
      # expect(cart.total.).to be 35
      expect(cart.total).to eq 35
    end

  end

  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡。" do
      cart = Cart.new
      i1 = FactoryBot.create(:item)
      i2 = FactoryBot.create(:item)

      3.times { cart.add_item(i1.id)}
      2.times { cart.add_item(i2.id)}

      result = {
        "items" => [
          { "item_id" => 1, "quantity" => 3},
          { "item_id" => 2, "quantity" => 2}
        ]
      }
      expect(cart.to_hash).to eq result
    end

    it "Hash還原成購物車的內容" do
      result = {
        "items" => [
          { "item_id" => 1, "quantity" => 3},
          { "item_id" => 2, "quantity" => 2}
        ]
      }

      cart = Cart.from_hash(result)
      # expect(cart.empty?).to be false
      expect(cart.items.count).to be 2

    end

  end
end
