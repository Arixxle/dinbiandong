class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
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
  end

  def edit
  end

  def update
    # debugger
    if @item.update(item_params)
      redirect_to item_path, notice: '成功更新餐點'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    # @item.update(deleted_at: Time.now)
    redirect_to items_path, notice: '成功刪除餐點'
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
