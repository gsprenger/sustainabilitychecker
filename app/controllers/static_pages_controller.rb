class StaticPagesController < ApplicationController
  def home
  end

  def legal
  	@license = File.read('LICENSE').gsub(/\n/, '<br>');
  end
end
