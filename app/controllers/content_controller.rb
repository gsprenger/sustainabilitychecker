class ContentController < ApplicationController
  respond_to :json
  def save
    success = true
    for index, data in params[:content]
      c = Content.find_by slug: index
      if (!c)
        c = Content.new(slug: index)
      end    
      if (data['type'] == 'image')
        c.content = data['attributes']['src']
      else
        c.content = data['value']
      end
      if (!c.save)
        success = false
      end
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to root_path }
    end
  end

  def get_all
    allContent = Content.all.each do |c|
      # Check for Glossary elements:
      c.content = c.content.gsub(/\[\[(\p{Alnum}+)\|(\p{Alnum}+)\]\]/) do |match|
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
    respond_to do |format|
      format.json { render json: allContent}
      format.html { redirect_to root_path }
    end
  end
end

