class AdminController < ApplicationController
  layout 'static_pages'
  http_basic_authenticate_with :name => "iaste", :password => IO.read(Rails.root+'.password').chomp
  def admin
  end
end

