class Content < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug, editType='full')
    c = Content.find_by_slug(slug)
    if (c)
      html = ''
      case editType
      when 'full'
        html += "<span data-mercury='full' id='#{c.slug.to_s}'>#{c.content}</span>"
      when 'simple'
        html += "<span data-mercury='simple' id='#{c.slug.to_s}'>#{c.content}</span>"
      when 'image'
        html += "<img data-mercury='image' id='#{c.slug.to_s}' src='#{c.content}'>"
      end
      return html.html_safe
    else
      return "<span data-mercury='full' id='#{slug}'>#{slug}</span>".html_safe
    end
  end
end
