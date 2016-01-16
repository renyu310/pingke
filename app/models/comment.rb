class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :content, presence: true, length: {minimum:1}
end
