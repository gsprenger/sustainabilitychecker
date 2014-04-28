class StaticPagesController < ApplicationController
  def home
    @isHome = true
  end

  def glossary
    @glossary = Glossary.all
  end

  def legal
  	@license = File.read('LICENSE').gsub(/\n/, '<br>')
  end
end
