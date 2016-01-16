class CommentsController < ApplicationController
  def create
    #@comment = Comment.new(comment_params)
    #@comment.save
    respond_to do |format|
      if @comment = Comment.create(comment_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.course
  end

  private
  def comment_params
    params.require(:comment).permit(:course_id, :user_id, :content)
  end

end
