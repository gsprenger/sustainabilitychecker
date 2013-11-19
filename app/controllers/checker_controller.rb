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
    if (e = log_with_session)
    elsif (e = log_with_cookie)
    else 
      e = new_log
    end
    # set session and cookie for later use
    cookies.permanent[:uid] = session[:uid] = e.id
    return e
  end
  
  def log_with_session
    session[:uid] ? Experiment.find_by(id: session[:uid]) : false
  end
  
  def log_with_cookie
    cookies[:uid] ? Experiment.find_by(id: cookies[:uid]) : false
  end
  
  def new_log
    e = Experiment.new(json: '{current: '', values: []}')
    e.save
    return e
  end

  def get_experiment
    e = Experiment.find_by id: params[:id]
    respond_to do |format|
      format.js { render json: [e] }
      format.html { redirect_to checker_path }
    end
  end

  def save_experiment
    if (e = Experiment.find_by id: params[:id])
      e.json = params[:json]
      success = e.save
    end
    respond_to do |format|
      format.js { render json: [success] }
      format.html { redirect_to checker_path }
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
      format.html { redirect_to checker_path }
    end
  end

  ###
  # View methods: Cards, Check
  ###
  def cards
    init_view
  end

  def check
    init_view
  end
end
