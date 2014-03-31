class ContentController < ApplicationController
  respond_to :json
  def save
    success = true
    for index, data in params[:content]
      if (c = Content.find_by id: index)
        if (data['type'] == 'image')
          c.content = data['attributes']['src']
        else
          c.content = data['value']
        end
        if (!c.save)
          success = false
        end
      else
        success = false
      end
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to root_path }
    end
  end

  def get_all
    respond_to do |format|
      format.json { render json: Content.all}
      format.html { redirect_to root_path }
    end
  end
end

