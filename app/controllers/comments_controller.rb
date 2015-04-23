class CommentsController < ApplicationController
  def index
    @comments = Comment.order('created_at DESC')
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end
 
  def create
    if current_user
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        flash[:success] = 'Your comment was successfully posted!'
      else
        flash[:error] = 'Your comment cannot be saved.'
      end
    end
    redirect_to :back
  end
   
  private
   
  def comment_params
    params.require(:comment).permit(:body)
  end
end