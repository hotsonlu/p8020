class User < ApplicationRecord


  def self.create_with_wechat(auth)
    create! do |user|
      user.provider = 'wechat'
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || auth['info']['nickname'] || ''
         user.avatar = auth['info']['headimgurl']
         user.sex = auth['info']['sex']
         user.province = auth['info']['province']
         user.city = auth['info']['city']
         user.country = auth['info']['country']
      end
    end
  end

  def update_user_info(auth)
    user = self
    if auth['info']
      user.name = auth['info']['name'] || auth['info']['nickname'] || ''
      user.avatar = auth['info']['headimgurl']
      user.sex = auth['info']['sex']
      user.province = auth['info']['province']
      user.city = auth['info']['city']
      user.country = auth['info']['country']
      user.save(validate: false)
    end
  end

end
