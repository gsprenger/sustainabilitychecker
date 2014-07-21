class SiteController < ApplicationController
  before_filter :check_mercury

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

  private
    def check_mercury
      @isMercury = !(/mercury/ =~ request.original_url).nil?
    end
end
