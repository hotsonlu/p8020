class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    # logger.debug auth
    # unionid = auth.extra.raw_info.unionid
    # raise "No unionid found, please check omniauth configure!" if unionid.blank?
    raise :test
    user = User.where(uid: uid.to_s).first
    if user.present?
      user.update_user_info(auth)
    else
      user = User.create_with_wechat(auth)
    end

    login_as(user)
    redirect_to root_path
  end
end
