class AppController < ApplicationController
  layout 'app'
  def app
    @inapp = true
    render 'app/app'
  end
end
