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
  
  # Looks for all cards in the cards folder and return them
  def load_cards
    html = ""
    Dir.entries(Rails.root + "app/views/checker/cards/").each { |entry|
      html += File.read(Rails.root + "app/views/checker/cards/" + entry) unless entry == '.' || entry == '..'
    }
    
    respond_to do |format|
      format.js { render text: html }
    end
  end

  ###
  # View methods: Variables, Check
  ###
  def variables
  end

  def check
  end
end
