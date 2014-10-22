class SiteController < ApplicationController
  before_filter :check_mercury
  skip_before_action :verify_authenticity_token

  def index
  end

  def more
  end

  def contact
  end

  def credits
  end

  def legal
    @license = File.read('LICENSE')
  end

  def glossary
    @glossary = Glossary.order('name')
    @glossarySplit = @glossary.in_groups(2, false)
  end

  def send_contact_email
    if (params[:name] != '' && params[:msg] != '')
      begin 
        ContactMailer.send_contact_email(params[:name], params[:msg], params[:email]).deliver
        success = true
      rescue
        success = false
      end
    else
      success = false
    end
    respond_to do |format|
      format.json { render json: {success: success} }
      format.html { redirect_to root_path }
    end
  end

  private
    def check_mercury
      @isMercury = !(/mercury/ =~ request.original_url).nil?
    end
end
