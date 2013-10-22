class ExperienceController < ApplicationController
  def begin
    # Init params for new experience and redirects
    session[:uid] = "toto#1452"
    
    redirect_to demand_path
  end
end
