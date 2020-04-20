class CommentsController < ApplicationController
  def create
    #寫法1
    # @comment = Comment.new(comment_params)
    # @comment.item_id = params[:item_id] 
    # @comment.user_id = current_user.id

    #寫法2
  #   @comment = Comment.new(comment_params,
                            # item_id: params[:item_id],
                            #  user_id: current_user.id )
  # @comment = current_user.comments.build(comment_params, user: current_user)  

    #寫法3
    @item = Item.find(params[:item_id])
    # @comment = current_user.comments.build(comment_params, item_id: @item.id)
    @comment = @item.comments.build(comment_params.merge(user: current_user)) #同上效果因為有belongs_to: item
    # @comment = current_user.comment.build(comment_params.merge(item: @item))
    # @comment.item = @item
    

    if @comment.save
      # redirect_to root_path, notice: 'OK'
      #轉到首頁，出現提示
      # redirect_to item_path(params[:item_id]), notice: 'Cool'
      #轉回同一個頁面出現flash

      #AJAX
      # render js: "alert('hi')"
      # render json: {name: '111', age: 18} #進console才看得到

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