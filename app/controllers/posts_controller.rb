class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :new, :create]}
  before_action :ensure_correct_user, {only: [:destroy, :close]}

  def allof
    @posts = Post.all.order(created_at: :desc)
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
      status: false
    )
    if @post.save
      flash[:notice] = "質問を投稿しました"
      redirect_to("/#{@current_user.id}")
    else
      render("posts/new")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @answers = Answer.where(post_id: @post.id)
    @answer = Answer.new
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/#{@current_user.id}")
  end

  def close
    @post = Post.find_by(id: params[:id])
    @post.status = true
    @post.save
    flash[:notice] = "回答を締め切りました"
    redirect_to("/#{@current_user.id}")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
