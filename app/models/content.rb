class Content < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug, editType='full')
    c = Content.find_by_slug(slug)
    html = ''
    case editType
    when 'full'
      html += "<div data-mercury='full' id='#{c.id.to_s}'>#{c.content}</div>"
    when 'simple'
      html += "<span data-mercury='simple' id='#{c.id.to_s}'>#{c.content}</span>"
    when 'image'
      html += "<img data-mercury='image' id='#{c.id.to_s}' src='#{c.content}'>"
    end
    html.html_safe
  end
end
