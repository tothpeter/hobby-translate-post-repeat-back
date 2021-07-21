# frozen_string_literal: true

require 'open-uri'

class ImageProxyController < ApplicationController
  def show
    url = Base64.decode64(CGI.unescape(params[:requested_image_url]))

    data = URI.open(url).read

    send_data data, type: 'image/jpeg', disposition: nil
  end
end
