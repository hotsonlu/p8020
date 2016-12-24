require "digest/sha1"

class WechatSupportsController < ApplicationController
  @@token = "shekou"

  def auth_wechat
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce     = params[:nonce]
    echostr   = params[:echostr]
    encrypt_str = Digest::SHA1.hexdigest([timestamp, nonce, TOKEN].sort.join)
    render text: "Forbidden", status: 403  unless encrypt_str == signature
  end
end
