class CheckerController < ApplicationController
  ###
  # Logic methods:
  ###  
  # Initialize is not used because we need the session context
  def init
    # determine session
    @session = retrieve_session
  end

  def retrieve_session
    session[:uid] || "None"
  end

  ###
  # View methods: Variables, Check
  ###
  def variables
  end

  def check
  end
end
