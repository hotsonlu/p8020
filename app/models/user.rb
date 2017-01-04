class User < ApplicationRecord
  enum role: [:reader, :writer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :writer_posts, class_name: 'Post', foreign_key: 'writer_id'

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :reader
    end
  end

  def admin?
    self.role.to_sym == :admin
  end

  def writer?
    admin? || self.role.to_sym == :writer
  end


  def self.create_with_wechat(auth)
    create! do |user|
      user.provider = 'wechat'
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || auth['info']['nickname'] || ''
        #  user.avatar = auth['info']['headimgurl']
        #  user.sex = auth['info']['sex']
        #  user.province = auth['info']['province']
        #  user.city = auth['info']['city']
        #  user.country = auth['info']['country']
      end
    end
  end

  def update_user_info(auth)
    user = self
    if auth['info']
      user.name = auth['info']['name'] || auth['info']['nickname'] || ''
      # user.avatar = auth['info']['headimgurl']
      # user.sex = auth['info']['sex']
      # user.province = auth['info']['province']
      # user.city = auth['info']['city']
      # user.country = auth['info']['country']
      user.save(validate: false)
    end
  end

end
