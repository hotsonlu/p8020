class Wechat::Reader::PostsController < Wechat::ApplicationController
  before_action :authenticate_user!, only: [:show, :index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
