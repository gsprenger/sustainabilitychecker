class CheckerController < ApplicationController
  require 'json'

  ###
  # Logic methods:
  ###  
  # Initialize is not used because we need the session context
  def init
    # determine session
    @session = retrieve_session
  end

  def retrieve_session
    session[:uid] || 'None'
  end
  
  # Looks for all cards in the cards folder and return them
  def load_cards
    cards = []
    Dir.entries(Rails.root + 'app/views/checker/cards/').each { |entry|
      unless entry == '.' || entry == '..'
        card = {
          name: entry.chomp('.html.erb'),
          html: File.read(Rails.root + 'app/views/checker/cards/' + entry) 
        }
        cards.push card
      end
    }
    
    respond_to do |format|
      format.js { render json: cards }
    end
  end

  ###
  # View methods: Variables, Check
  ###
  def variables
    @nav = %w[demographics diet households services density agriculture energy industrialization]
  end

  def check
  end
end
