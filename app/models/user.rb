class User < ActiveRecord::Base
  enum role: [:visitor, :editor, :staff, :admin]
  enum status: [:active, :archived]

  has_one :profile
  accepts_nested_attributes_for :profile, allow_destroy: true

  default_scope { where(status: User.statuses[:active]) }

  after_initialize :set_role

  has_many :projects

  has_many :favorite_projects # just the 'relationships'
  has_many :favorites, through: :favorite_projects, source: :project
  belongs_to :last_lesson, class_name: 'Lesson', foreign_key: 'last_lesson_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def hidden_email
    tokens = self.email.split /\@/
    name = tokens[0]
    domain = tokens[1]
    "#{name[0,3]}...#{name[-3,3]}@#{domain}"
  end

  def set_last_viewed(lesson:)
    return if lesson.nil?
    self.last_lesson = lesson
    self.save if self.changed?
  end

  private
  def set_role
    self.role ||= 'visitor'
  end

end
