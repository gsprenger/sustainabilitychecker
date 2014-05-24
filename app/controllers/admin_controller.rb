class AdminController < ApplicationController
  http_basic_authenticate_with :name => "iaste", :password => (ENV['ADMIN_PWD'] || 'dev')
  
  def admin     
    @glossaries = Glossary.order('name')
    p @glossaries
  end
end

