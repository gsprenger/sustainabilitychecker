class Content < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug, editType='full')
    c = Content.find_by_slug(slug)
    if (c)
      html = ''
      case editType
      when 'full'
        html += "<div data-mercury='full' id='#{c.slug.to_s}'>#{c.content}</div>"
      when 'simple'
        html += "<span data-mercury='simple' id='#{c.slug.to_s}'>#{c.content}</span>"
      when 'image'
        html += "<img data-mercury='image' id='#{c.slug.to_s}' src='#{c.content}'>"
      end
      html = Content.checkForGlossaryEntries(html)
      return html.html_safe
    else
      return "<span data-mercury='full' id='#{slug}'>#{slug}</span>".html_safe
    end
  end
  
  def self.checkForGlossaryEntries (html)
    html = html.gsub(/\[\[([\p{Alnum}\s]+)\|(\p{Alnum}+)\]\]/) do |match|
      text = $1
      slug = $2
      g = Glossary.find_by slug: slug
      if (g)
        definition = g.definition.gsub(/\'/, "&#39;").gsub(/\"/, "&#34;")
        p "<span class='glossary-entry' title='#{g.name}: #{definition}'>#{text}</span>"
      else
        text
      end
    end
  end
end
