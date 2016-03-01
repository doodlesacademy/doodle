class Lesson < ActiveRecord::Base
  include Slugable
  include Sectionable
  
  enum status: [:active, :archive]
  default_scope { where(status: Lesson.statuses[:active]) }

  has_and_belongs_to_many :supply_items
  has_many :instruction_groups
  has_many :instructions, through: :instruction_groups
  belongs_to :project, counter_cache: true

  accepts_nested_attributes_for :instruction_groups, :instructions
  after_create :create_instruction_groups

  validates :title, presence: true
  validates :video_uri, presence: true
  alias_attribute :name, :title

  has_sections lesson_overview: [:synopsis, :objective, :setup, :media, :photocopies, :anticipated_problems, :early_finishers], instructions: [:inspiration, :introduction, :worktime, :clean_up, :presentations]
    
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

  def create_instruction_groups
    %w(Inspiration Introduction Worktime Clean-Up/Presentations).each do |title|
      self.instruction_groups.create(title: title)
    end
  end

end
