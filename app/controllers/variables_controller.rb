class VariablesController < ApplicationController
  def supply
    @user = retrieve_user
    @type = "Supply"
    render :variables
  end

  def demand
    @user = retrieve_user
    @type = "Demand"
    render :variables
  end

  def retrieve_user
    session[:uid] || "None"
  end
end
