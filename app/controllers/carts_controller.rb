class CartsController < ApplicationController
  # def show
  # end

  def destroy
    session[:carty] = nil
    redirect_to root_path, notice: '購物車已清空'
  end

  def checkout
    @order = Order.new

    gateway = Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => 'p2dgfsf3vpwz7575',
      :public_key => 'ndjyygsw8x94q2nm',
      :private_key => '483c0f9c850e4182ae7488a2acb62574',
    )
    @token = gateway.client_token.generate
  end

end
