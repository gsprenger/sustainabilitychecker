class StaticPagesController < ApplicationController
  def home
  end

  def presentation
  end

  def contact
  end

  def contact_send
    success = "failure"

    c = Contact.new(params)
    success = "success" if c.deliver 

    respond_to do |format|
      format.html { render :json => success, :status => :ok }
    end
  end

  def legal
  	@license = File.read('LICENSE').gsub(/\n/, '<br>');
  end
end
