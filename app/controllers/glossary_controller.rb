class GlossaryController < ApplicationController
  respond_to :json
  def new
    success = true
    for i, entry in params[:glossary]
      g = Glossary.find_by name: entry[:name]
      if (!g)
        g = Glossary.new(name: entry[:name])
        g.slug = entry[:slug]
        g.definition = entry[:def]
        if (!g.save)
          success = false
          msg = "<p><b>Message from server:</b> An entry with the slug <i>#{entry[:slug]}</i> already exists or a server bug happened.</p>"
        end
      else
        success = false
        msg = "<p><b>Message from server:</b> An entry with the name <i>#{entry[:name]}</i> already exists.</p>"
      end
    end
    respond_to do |format|
      format.json { render json: {success: success, message: msg} }
      format.html { redirect_to root_path }
    end
  end

  def edit
    success = true
    name = params[:name]
    pname = params[:pname]
    slug = params[:slug]
    definition = params[:def]
    g = Glossary.find_by name: pname
    if (!g)
      success = false
      msg = "<p><b>Message from server:</b> the entry with the name <i>#{name}</i> can't be found.</p>"
    else
      g.name = name
      g.slug = slug
      g.definition = definition
      if (!g.save)
        success = false
        msg = "<p><b>Message from server:</b> the entry can't be saved, check that its name and slug are unique.</p>"
      end
    end
    respond_to do |format|
      format.json { render json: {success: success, message: msg} }
      format.html { redirect_to root_path }
    end
  end

  def remove
    success = true
    name = params[:name]
    g = Glossary.find_by name: name
    if (!g)
      success = false
      msg = "<p><b>Message from server:</b> the entry with the name <i>#{name}</i> can't be found.</p>"
    else
      g.destroy()
    end
    respond_to do |format|
      format.json { render json: {success: success, message: msg} }
      format.html { redirect_to root_path }
    end
  end
end

