class CheckerController < ApplicationController
  require 'json'

  ###
  # Logic methods:
  ###  
  # Initialize is not used because we need the session context
  def init_view
    @experiment = log_in
  end

  def log_in
    if session[:uid] 
      e = Experiment.find_by id: session[:uid]
    end
    # if no session or cant find the one recorded in the session: check cookies
    unless session[:uid] && e
      if cookies[:uid]
        e = Experiment.find_by id: cookies[:uid]
      end 
      unless cookies[:uid] && e
        e = Experiment.new(json: '{}')
        e.save
      end
    end

    cookies.permanent[:uid] = session[:uid] = e.id
    return e
  end

  def get_experiment
    e = Experiment.find_by id: params[:id]
    respond_to do |format|
      format.js { render json: e }
    end
  end

  def save_experiment
    if (e = Experiment.find_by id: params[:id])
      e.json = params[:json]
      success = e.save
    end
    respond_to do |format|
      format.js { render json: success }
    end
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
    init_view
  end

  def check
    init_view
  end
end