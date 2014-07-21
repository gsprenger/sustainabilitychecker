class Content < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  def self.text (slug, isMercury=true, editType='full')
    c = Content.find_by_slug(slug)
    if (c)
      html = ''
      case editType
      when 'simple'
        html += "<span data-mercury='simple' id='#{c.slug.to_s}'>#{c.content}</span>"
      when 'image'
        html += "<img data-mercury='image' id='#{c.slug.to_s}' src='#{c.content}'>"
      when 'raw'
        html += c.content
      when 'full'
        html += "<div data-mercury='full' id='#{c.slug.to_s}'>#{c.content}</div>"
      else
        html += "<div data-mercury='full' id='#{c.slug.to_s}'>#{c.content}</div>"
      end
      if (!isMercury)
        html = Content.checkForGlossaryEntries(html)
      end
      return html.html_safe
    else
      case editType
      when 'raw'
        return slug
      else
        return "<div data-mercury='full' id='#{slug}'>#{slug}</div>".html_safe
      end
    end
  end
  
  def self.checkForGlossaryEntries (html)
    html = html.gsub(/\[\[([\p{Alnum}\s]+)\|(\p{Alnum}+)\]\]/) do |match|
      text = $1
      slug = $2
      g = Glossary.find_by slug: slug
      if (g)
        definition = g.definition.gsub(/\'/, "&#39;").gsub(/\"/, "&#34;")
        "<span class='glossary-entry' data-toggle='popover' data-content='#{definition}' data-title='#{g.name}'>#{text}</span>"
      else
        text
      end
    end
  end
end
