class StaticPagesController < ApplicationController
  def home
  end

  def presentation
  end

  def contact
  end

  def legal
  	@license = File.read('LICENSE').gsub(/\n/, '<br />');
  end
end
