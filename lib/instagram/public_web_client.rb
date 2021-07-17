# frozen_string_literal: true

require 'net/http'

module Instagram::PublicWebClient
  def self.fetch_profile_info(user_name)
    url = "https://www.instagram.com/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response, symbolize_names: true)[:graphql][:user]
  end

  def self.fetch_latest_posts_by_user_name(user_name, limit: 50)
    profile_info = fetch_profile_info(user_name)
    user_id      = profile_info[:id]

    fetch_lates_posts_by_user_id(user_id, limit: limit)
  end

  def self.fetch_lates_posts_by_user_id(user_id, limit: 50)
    posts = []
    number_of_remaining_posts_to_fetch = limit

    url = "https://www.instagram.com/graphql/query/?query_hash=ea4baf885b60cbf664b34ee760397549&variables={\"id\":\"#{user_id}\",\"first\":#{number_of_remaining_posts_to_fetch}}"

    loop do
      uri = URI(url)
      response = Net::HTTP.get(uri)
      json_data = JSON.parse(response, symbolize_names: true)

      fetched_posts = json_data[:data][:user][:edge_owner_to_timeline_media][:edges].map { |edge| edge[:node] }
      posts += fetched_posts

      number_of_remaining_posts_to_fetch -= fetched_posts.count
      page_info = json_data[:data][:user][:edge_owner_to_timeline_media][:page_info]

      break if number_of_remaining_posts_to_fetch < 1 || !page_info[:has_next_page]

      url = "https://www.instagram.com/graphql/query/?query_hash=ea4baf885b60cbf664b34ee760397549&variables={\"id\":\"#{user_id}\",\"first\":#{number_of_remaining_posts_to_fetch},\"after\":\"#{page_info[:end_cursor]}\"}"
    end

    posts
  end
end
