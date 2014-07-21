class AdminController < ApplicationController
  before_filter :check_mercury
  http_basic_authenticate_with :name => "iaste", :password => (ENV['ADMIN_PWD'] || 'dev')
  
  def uneditables
  end

  def admin     
    @glossaries = Glossary.order('name')
    p @glossaries
  end

  private
    def check_mercury
      @isMercury = !(/mercury/ =~ request.original_url).nil?
    end
end

