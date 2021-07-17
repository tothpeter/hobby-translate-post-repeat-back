# frozen_string_literal: true

require 'net/http'

module Instagram::PublicWebClient
  def self.fetch_profile(user_name)
    url = "https://www.instagram.com/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response, symbolize_names: true)
  end

  def self.fetch_latest_posts_of(user_name)
    url = "https://www.instagram.com/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    json_data = JSON.parse(response, symbolize_names: true)

    json_data[:graphql][:user][:edge_owner_to_timeline_media][:edges]
      .map { |edge| edge[:node] }
  end
end
