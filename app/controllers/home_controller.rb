class HomeController < ApplicationController
  require 'open-uri'

  def index

  end

  def scrap
    url = params[:scrap][:url]
    url = 'http://www.google.co.in' if url == ''
    js = "<script src='//code.jquery.com/jquery-1.11.1.min.js'></script><script>$(document).ready(function()
           { $('a').click(function(e){e.preventDefault(); alert($(this).attr('href'));
            window.location.href='/mail?url=$(this).attr('href'); });});</script>".html_safe
    Rails.logger.info p url
    open(Rails.root.to_s+ '/scraper.html', 'wb') do |file|
      open(url) do |uri|
        file.write(uri.read+js)
      end
      FileUtils.mv(Rails.root.to_s+ '/scraper.html', Rails.root.to_s + '/public')
      redirect_to '/scraper.html'
    end
  end

end
