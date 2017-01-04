class Post < ApplicationRecord
  MAX_TITLE_LENGTH = 82
  MAX_SUMMARY_LENGTH = 140

  if ENV['USER_TEST_DEBUG'].present?
    MIN_CONTENT_LENGTH = 10
  else
    MIN_CONTENT_LENGTH = 220
  end

  belongs_to :writer, class_name: 'User', foreign_key: 'writer_id'

  validates :title, presence: { message: '请输入标题' }
  validates :content, presence: true

  validates_length_of :summary, maximum: (MAX_SUMMARY_LENGTH + 60)
  validates_length_of :title, maximum: MAX_TITLE_LENGTH

  validates_length_of :content, minimum: MIN_CONTENT_LENGTH

end
