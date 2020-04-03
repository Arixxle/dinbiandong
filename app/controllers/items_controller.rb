class ItemsController < ApplicationController
  def index
    
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

  private
  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :description,
                                 :spec)
  end
end
