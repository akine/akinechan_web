class OuraringsController < ApplicationController
  def index

  end

  def show
    @result = "リザルト"
    params = URI.encode_www_form({
      response_type: "code",
      client_id: "LGHNHWL4RVJPHXYS",
    })
    uri = URI.parse("https://cloud.ouraring.com/oauth/authorize?#{params}")
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.get(uri.request_uri)
    end
    p response
    p uri

    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    
    # エラー時処理
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"
    end

  end
end
