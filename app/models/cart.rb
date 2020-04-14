class Cart
  def initialize(items = [])
    @items = items
  end
  
  def add_item(item_id)
    found_item = @items.find { |item| item.item_id == item_id }

    if found_item
      found_item.increment!
    else
      @items << CartItem.new(item_id)
    end

  end

  def empty?
    @items.empty?
  end

  def items
    @items
  end

  def total
    result = @items.reduce(0) { |sum, item| sum + item.total }
    if Time.now.month == 4 and Time.now.day == 1
      # 4/1全館打1折
      result = result * 0.1
    end
    return result

    # @items.sum { |item| item.total}

    # tmp = 0
    # @items.each do |item|
    #   tmp += item.total
    # end
  end

  def to_hash
    # items = [
    #   { "item_id" => 1, "quantity" => 3},
    #   { "item_id" => 2, "quantity" => 2}
    # ]

    # items = []
    # @items.each do |item|
    #   items << { "item_id" => item.item_id,
    #              "quantity" => item.quantity }

    # end

    items = @items.map{ |item| 
    { "item_id" => item.item_id,
      "quantity" => item.quantity }
    }

    result = {
      "items" => items
    }
  end

  def self.from_hash(hash = nil)
    if hash && hash["items"]
      items = []
      hash["items"].each do |item|
        items << CartItem.new(item["item_id"], item["quantity"])
      end
      Cart.new(items)
    else
      Cart.new
    end
  end

end
