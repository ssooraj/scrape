class HomeController < ApplicationController
  require 'open-uri'

  def index

  end

  def scrap
    url = params[:scrap][:url]
    url = 'http://www.google.co.in' if url == ''
    mechanize = Mechanize.new
    page = mechanize.get(url)
    total_content = "<script type='text/javascript' src= 'https://code.jquery.com/jquery-2.1.4.min.js'></script>".html_safe + page.body.html_safe + script(url)
    File.open(Rails.root.to_s+'/public/scraper.html', 'wb') { |file| file.write(total_content) }
    redirect_to '/scraper.html'
  end

  def image
    # http://static4.businessinsider.com/image/54228ba76da8110a73d652eb-960/emma-watson.jpg
    open(CGI::unescape(params[:url]), 'rb') do |f|
      send_data f.read, :type => f.content_type, :disposition => "inline"
    end
  end

  def script(page)
    "
    <script type='text/javascript'>
    $(function() {
      var interval = setInterval(change_links,1000);
      function change_links(){
        $( 'a' ).each(function( index ) {
        console.log('polo');
        var link = $( this ).attr('href'); 
        if(link){
          if(link[0] == '/'){
            $( this ).attr('href', '/get_page?page=http://#{get_host_without_www(page)}'+link);
          }else{
            $( this ).attr('href', '/get_page?page='+link);
          }
        }
      });
      clearInterval(interval);
      } 
      

    });
    </script>
    ".html_safe
  end

  def get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end


end
