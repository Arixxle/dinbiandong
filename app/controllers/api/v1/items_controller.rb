class Api::V1::ItemsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # skip_before_action :check_login
  def favorite
    item = Item.find(params[:id]) #先把資料翻出來
    if item.favorite_by(current_user)
      #移除最愛
      current_user.items.delete(item)
      render json: {status: 'removed'}
    else
      #加最愛
      current_user.items << item
      render json: {status: 'favorited'}
    end

    # render json: {name: 'aaa', age: 18}
  end
end
