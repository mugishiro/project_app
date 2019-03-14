class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}

  def allof
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "default"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを登録しました"
      redirect_to("/#{@user.id}")
    else
      if params[:name].blank?
        @error_message = "fe"
      end
      @error_message = "メールアドレスが既に利用されています"
      @email = params[:email]
      @password = params[:password]
      render("users/new")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email],
                         password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/edit")
    end
  end

  def index
    @users = User.where.not(id: @current_user.id)
  end

  def show
    @post = Post.new
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(created_at: :desc).where(status: false)
  end

  def close
    @post = Post.new
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(created_at: :desc).where(status: true)
  end

end
