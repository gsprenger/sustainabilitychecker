class AdminController < ApplicationController
  http_basic_authenticate_with :name => "iaste", :password => (ENV['ADMIN_PWD'] || 'dev')
  
  def admin     
  end
end

