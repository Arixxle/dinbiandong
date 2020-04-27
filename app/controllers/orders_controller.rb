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
      result = gateway.transaction.sale(
        :amount => current_cart.total,
        :payment_method_nonce => params[:order][:nonce] #效果同下
        # :payment_method_nonce => order_params[:nonce]
      )
      if result.success?
        #成功
        #清空購物車
        @order.pay!
        session[:carty] = nil
      redirect_to root_path, notice: '交易成功'
      else
        #失敗
      redirect_to root_path, notice: '交易失敗'
      end    
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
