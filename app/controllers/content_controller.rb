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
    if !request.original_url.include? "/editor/"
      allContent = Content.all.each do |c|
        c.content = Content.checkForGlossaryEntries(c.content)
        c
      end
    else
      allContent = Content.all
    end
    respond_to do |format|
      format.json { render json: allContent}
      format.html { redirect_to root_path }
    end
  end
end

