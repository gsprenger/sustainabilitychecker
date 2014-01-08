class Checker2Controller < ApplicationController
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

  ###
  # API methods:
  ###  
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

  ###
  # View method: app
  ###
  def app
    @experiment = log_in
  end
end

