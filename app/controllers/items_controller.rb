class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, 
  with: :record_not_found

  def index
      @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      # flash[:notice] = 'Items had been added!'
      redirect_to items_path, notice: 'Items had been added!'
    else
      render :new
    end   
  end

  def show
    @item = Item.find(params[:id])
  end
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path, notice: '成功刪除餐點'
  end
  private
  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :description,
                                 :spec)
  end
  def record_not_found
    # redirect_to items_path, notice: '找嘸!'
    render file: 'public/404.html', 
    status: 404, 
    layout: false
  end

end
