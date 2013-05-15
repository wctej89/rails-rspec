class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title

  validates_presence_of :title, :content

  after_save :generate_slug



  

  def generate_slug
    self.slug = self.title.parameterize
  end

  private

  def titleize_title
    self.title = title.capitalize
  end
end
