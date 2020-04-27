class OrdersController < ApplicationController
  def create
    # @order = Order.new(order_params)
    # @order.user = current_user
    
    # 效果同上兩行
    @order = current_user.orders.build(order_params)
    current_cart.items.each do |cart_item|
      item = OrderItem.new(item: cart_item.item,
                           price: cart_item.item.price, 
                           quantity: cart_item.quantity)
      @order.order_items << item
    end


    if @order.save
      #刷卡
      #清空購物車
      redirect_to root_path, notice: 'ok'
    else
      redirect_to root_path, notice: 'not ok'   
    end

    # render html:params
  end

  private
  def order_params
    params.require(:order).permit(:receiver, :phone, :address)
  end

end
