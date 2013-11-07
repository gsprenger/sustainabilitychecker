class VariablesController < ApplicationController
  layout "app"

  ###
  # Non visual methods:
  ###
  
  # Initialize is not used because we need the session context
  def init
    @user = retrieve_user
  end

  def retrieve_user
    session[:uid] || "None"
  end

  ###
  # Index actions: Demand Supply
  ###
  def demand
    render nil
  end

  def supply
    render nil
  end

  ###
  # Demand views
  ###
  def demographics
  end
  
  def diet
  end
  
  def households
  end

  ###
  # Supply views
  ###
  def services
  end
  
  def electricity
  end
  
  def fuels
  end
  
  def industrialization
  end
end
