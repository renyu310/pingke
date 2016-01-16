class User < ActiveRecord::Base

  #-------------------------表关系处理-------------------------------------#
  has_and_belongs_to_many :courses  #与课程关系


  has_many :comments, dependent: :destroy

  #关注功能
  has_many :active_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #微博功能
  has_many :microposts, dependent: :destroy
  #------------------------------------------------------------------------#

  #--------------------------------模型相关约束和验证----------------------------------------#
  before_save {self.email == email.downcase}
  has_secure_password  #密码哈希处理

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum: 255}, format:{with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  validates :password, length: {minimum:6}, allow_blank: true

  #----------------------------------------------------------------------------------------#
  #---------------------------------------相关函数------------------------------------------#
  #关注用户
  def follow(other_user)
    active_relationships.create(followed_id:other_user.id)
  end

  #取消关注
  def unfollow(other_user)
    active_relationships.find_by(followed_id:other_user.id).destroy
  end

  #判断是否已经关注指定用户 是的话返回true
  def following?(other_user)
    following.include?(other_user)
  end

  #关注课程
  def follow_course(course)
    self.courses << course
  end

  def unfollow_course(course)
    self.courses.destroy(course)
  end

  def following?(course)
    self.courses.include?(course)
  end


  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def avatar(with=80)
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{with}&d=retro"
  end

end
