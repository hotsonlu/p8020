require "digest/sha1"

class WechatSupportsController < ApplicationController
  @@token = "shekou"

  def auth_wechat
    if check_signature?(params[:signature],params[:timestamp],params[:nonce])
     return render text: params[:echostr]
    end
  end
 private
  def check_signature?(signature,timestamp,nonce)
    Digest::SHA1.hexdigest([timestamp,nonce,@@token].sort.join) == signature
  end
end
