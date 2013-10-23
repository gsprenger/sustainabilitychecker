class VariablesController < ApplicationController
  # initialize is not used because we need the session context
  def init
    @user = retrieve_user
    @type = params[:action]
    @model = Variables.get_structured(@type)
  end

  def supply
    init
    render :variables
  end

  def demand
    init
    render :variables
  end

  def retrieve_user
    session[:uid] || "None"
  end
end
