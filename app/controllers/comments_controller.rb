class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.build(comment_params.merge(user: current_user)) 
    
    if @comment.save


    else
      # redirect_to item_path(params[:item_id]), notice: 'No good!'
      render 'items/show' #要保留剛輸入的資料
    end   
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end