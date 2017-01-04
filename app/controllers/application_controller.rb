class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :wechat?

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return true if current_user
  end

  def authenticate_user!
    if wechat? && current_user.blank?
      logout
      redirect_to '/auth/wechat'
      return
    end
  end
  #
  #   if ! wechat? && ( current_user.blank? || current_user.open_wechat_openid.blank? )
  #     logout
  #     redirect_to '/auth/open_wechat'
  #     return
  #   end
  #
  #   if current_user.lock?
  #     logout
  #     redirect_to root_path, :alert => '你的帐号已被锁定, 如有疑问, 请 与我们取得联系'
  #     return
  #   end
  # end

  def authenticate_admin!
    if !current_user
      redirect_to root_path, :alert => '请先登录'
      return
    end

    if !current_user.admin?
      redirect_to root_path, :alert => '没有权限'
    end
  end

  def login_as(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
    cookies.signed[:user_id] = nil
  end

  def wechat?
    browser.wechat?
  end

end
