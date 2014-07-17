class ShortenerController < ApplicationController
  respond_to :json

  def shorten
    domain = /\A(.*)\/load\/\w+\z/.match(params[:url]).captures
    shortenerObj = Shortener::ShortenedUrl.generate(params[:url])
    shrtUrl = "#{domain[0]}/shrt/#{shortenerObj.unique_key}"
    respond_to do |format|
      format.json { render json: {shrturl: shrtUrl} }
      format.html { redirect_to root_path }
    end
  end
end

