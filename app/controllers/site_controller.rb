class SiteController < ApplicationController
  def index
  end

  def more
  end

  def contact
  end

  def credits
  end

  def legal
    @license = File.read('LICENSE').gsub(/\n/, '<br>')
  end

  def glossary
    @glossary = Glossary.order('name')
  end
end
