class Content < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug, editType='full')
    c = Content.find_by_slug(slug)
    ('<span data-mercury="' + editType + '" id="' + c.id.to_s + '">' + c.content + '</span>').html_safe
  end
end
