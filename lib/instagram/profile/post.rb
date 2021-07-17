# frozen_string_literal: true

require 'net/http'

module Instagram::Profile::Post
  def self.latest_posts(user_name)
    url = "https://www.instagram.com/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    json_data = JSON.parse(response, symbolize_names: true)

    json_data[:graphql][:user][:edge_owner_to_timeline_media][:edges]
      .map { |edge| edge[:node] }
  end
end
