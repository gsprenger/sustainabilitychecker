class Content < ActiveRecord::Base
  validates :slug, :content, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug)
    c = Content.find_by_slug(slug).content.html_safe
  end
end
