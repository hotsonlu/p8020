class Wechat::Writer::PostsController < Wechat::ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.writer_posts.order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def show
    @post = current_user.writer_posts.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.writer = current_user
    if @post.save
      redirect_to wechat_writer_post_path(@post)
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :summary, :content)
  end
end
