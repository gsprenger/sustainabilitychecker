class GlossaryController < ApplicationController
  respond_to :json
  def save
    success = true
    for name, definition in params[:glossary]
      g = Glossary.find_by name: name
      if (!g)
        g = Glossary.new(name: name)
      end    
      g.definition = definition
      if (!g.save)
        success = false
      end
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to root_path }
    end
  end

  def edit
    success = true
    name = params[:name]
    definition = params[:definition]
    g = Glossary.find_by name: name
    if (!g)
      success = false
    else
      g.definition = definition
      if (!g.save)
        success = false
      end
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to root_path }
    end
  end

  def remove
    success = true
    name = params[:name]
    definition = params[:definition]
    g = Glossary.find_by name: name
    if (!g)
      success = false
    else
      g.destroy()
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

