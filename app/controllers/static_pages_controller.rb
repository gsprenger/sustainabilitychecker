class StaticPagesController < ApplicationController
  def home
  end

  def presentation
  end

  def contact
  end

  def contact_send
    c = Contact.new(params)
    if c.deliver 
      render json: "{success: true}"
    else
      render json: "{success: false}"
    end
  end

  def legal
  	@license = File.read('LICENSE').gsub(/\n/, '<br />');
  end
end
