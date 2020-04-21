class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy, :add_to_cart]
  def index
    # @items = Item.all
    # @items = Item.where(deleted_at: nil)
    # @items = Item.available
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: 'Items had been added!'
    else
      render :new
    end   
  end

  def show
    @category = @item.category.name
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
  end

  def update
    # debugger
    if @item.update(item_params)
      redirect_to item_path, notice: '成功更新餐點'
    else
      render :edit
      # redirect_to item_path
    end
  end

  def destroy
    @item.destroy
    # @item.update(deleted_at: Time.now)
    redirect_to items_path, notice: '成功刪除餐點'
  end

  def add_to_cart
    cart = Cart.from_hash(session[:carty])
    cart.add_item(@item.id)
    session[:carty] = cart.to_hash

    redirect_to '/', notice: 'OK 加到購物車'
  end

  private
  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :description,
                                 :category_id,
                                 :spec,
                                 :cover)
  end
  def find_item
    @item = Item.find(params[:id])
    # @item = Item.find_by!(id: params[:id], deleted_at: nil) #Item.available
  end
end
