class VariablesController < ApplicationController
  layout "app"

  ###
  # Helpers:
  ###  
  # Initialize is not used because we need the session context
  def init part
    # determine part
    @part = part

    # determine section
    if part == 'demand'
      sections = %w[demographics diet households] 
    elsif part == 'supply'
      sections = %w[services electricity fuels industrialization]
    end
    @section = params[:section]
    @section = sections[0] unless 
      sections.any? { |p| @section == p }

    # determine session
    @session = retrieve_session
  end

  def retrieve_session
    session[:uid] || "None"
  end

  ###
  # Index actions: Demand Supply
  ###
  def demand
    init 'demand'
    render :demand
  end

  def supply
    init 'supply'
    render :supply
  end
end
