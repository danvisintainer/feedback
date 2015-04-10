class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.create(comment_params)
    @comment.save
    binding.pry
    redirect_to "/projects/#{@project.id}"
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
