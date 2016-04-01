class Lesson < ActiveRecord::Base
  include Slugable
  include Sectionable
  
  enum status: [:active, :archive]
  default_scope { where(status: Lesson.statuses[:active]) }

  has_and_belongs_to_many :supply_items
  belongs_to :project, counter_cache: true

  validates :title, presence: true
  validates :video_uri, presence: true
  alias_attribute :name, :title
  after_create :set_position

  has_sections overview: [:synopsis, :objective, :setup, :media, :photocopies, ], instructions: [:inspiration, :introduction, :worktime, :clean_up, :presentations], issues: [:anticipated_problems, :early_finishers]
  has_attached_file :inspiration_image, 
    styles: { large: "900x900>", medium: "300x300>", thumb: "100x100>" }, 
    default_url: "images/:style/missing.png"
  validates_attachment_content_type :inspiration_image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_attached_file :overview, 
    styles: {thumbnail: "60x60#"},
    default_url: ""
  validates_attachment_content_type :overview, content_type: ["application/pdf"]

  def video_id
    return unless @video_uri.present?
    @video_uri.match(/\d+$/).to_s
  end

  def destroy
    self.archive!
    self.save!
  end

  private

  def set_position
    self.position ||= self.project.lessons.count - 1
  end

end
