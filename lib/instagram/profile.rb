# frozen_string_literal: true

require 'net/http'

module Instagram::Profile
  def self.fetch_plain_data(user_name)
    url = "https://www.instagram.com/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response, symbolize_names: true)
  end
end
