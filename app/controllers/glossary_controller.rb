class GlossaryController < ApplicationController
  respond_to :json
  def save
    success = true
    p params[:glossary]
    for index, data in params[:content]
      g = Glossary.find_by name: index
      if (!g)
        g = Glossary.new(name: index)
      end    
      g.definition = data['definition']
      if (!g.save)
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
      format.json { render json: Glossary.all}
      format.html { redirect_to root_path }
    end
  end
end

