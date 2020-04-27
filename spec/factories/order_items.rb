FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    item { nil }
    price { 1 }
  end
end
