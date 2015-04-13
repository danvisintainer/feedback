class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        
        # format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.js   { }
      #   format.json { render :show, status: :created, location: @comment }
      # else
        # format.html { render :new }
        # format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end    
# binding.pry
    # redirect_to "/projects/#{@project.id}"
  end
 
  private
    def comment_params
      params.require(:comment).permit(:user_id, :body)
    end
end
