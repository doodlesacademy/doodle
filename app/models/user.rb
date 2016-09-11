class User < ActiveRecord::Base
  enum role: [:visitor, :editor, :staff, :admin]
  enum status: [:active, :archived]

  default_scope { where(status: User.statuses[:active]) }

  after_initialize :set_role

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def salutation
    self.gender.downcase == "m" ? "Mr." : "Mrs."
  end

  private
  def set_role
    self.role ||= 'visitor'
  end

end
