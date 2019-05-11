class AnswersController < ApplicationController

  def allof
    @answers = Answer.all
  end

  def new
    @id = params[:id]
  end

  def index
    @answers = Answer.all.order(created_at: :desc)
    
  end

  def create
    @answer = Answer.new(
      post_id: params[:id],
      content: params[:content],
      user_id: @current_user.id
    )
    if @answer.save
      flash[:notice] = "回答しました"
      redirect_to("/posts/#{params[:id]}")
    else
      @post = Post.find_by(id: params[:id])
      @answers = Answer.where(post_id: @post.id)
      render("posts/show")
    end
  end
end
