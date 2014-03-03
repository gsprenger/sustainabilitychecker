class ContentController < ApplicationController
  def save
    success = true
    for index, data in params[:content]
      if (c = Content.find_by id: index)
        c.content = data['value']
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
end

