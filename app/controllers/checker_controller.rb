class CheckerController < ApplicationController
  require 'json'

  ###
  # Logic methods:
  ###  
  def log_in
    if (e = log_with_session)
    elsif (e = log_with_cookie)
    else 
      e = new_log
    end
    # set session and cookie for later use
    cookies.permanent[:expid] = session[:expid] = e.id
    return e
  end
  
  def log_with_session
    session[:expid] ? Experiment.find_by(id: session[:expid]) : false
  end
  
  def log_with_cookie
    cookies[:expid] ? Experiment.find_by(id: cookies[:expid]) : false
  end
  
  def new_log
    e = Experiment.new(json: '{"current": "", "values": []}')
    e.save
    return e
  end

  def get_experiment
    e = Experiment.find_by id: params[:id]
    respond_to do |format|
      format.json { render json: e }
      format.html { redirect_to checker_path }
    end
  end

  def save_experiment
    if (e = Experiment.find_by id: params[:id])
      e.json = params[:json]
      success = e.save
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to checker_path }
    end
  end
  
  # Looks for all cards in the cards folder and return them
  def load_cards
    cards = []
    Dir.entries(Rails.root + 'app/views/checker/cards/').each { |entry|
      unless entry == '.' || entry == '..'
        /([^\.]+)-([^\.]+)-([^\.]+)\.html\.erb/.match(entry)
        card = {
          id: $1,
          name: $2,
          slug: $3,
          html: File.read(Rails.root + 'app/views/checker/cards/' + entry) 
        }
        cards[$1.to_i-1] = card
      end
    }
    
    respond_to do |format|
      format.json { render json: cards }
      format.html { redirect_to checker_path }
    end
  end

  ###
  # View methods: Cards, Check
  ###
  def index
    @experiment = log_in
  end
end

