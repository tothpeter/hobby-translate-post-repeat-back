# frozen_string_literal: true

require 'net/http'

module Instagram::PublicWebClient
  BASE_URL             = 'https://www.instagram.com'
  QUERY_HASH_FOR_POSTS = 'ea4baf885b60cbf664b34ee760397549'

  def self.fetch_profile_info(user_name)
    url = "#{BASE_URL}/#{user_name}/?__a=1"
    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response, symbolize_names: true)[:graphql][:user]
  end

  def self.latest_posts_by_user_name(user_name, limit: 50)
    profile_info = fetch_profile_info(user_name)
    user_id      = profile_info[:id]

    latest_posts_by_user_id(user_id, limit: limit)
  end

  def self.latest_posts_by_user_id(user_id, limit: 50)
    posts = []
    number_of_remaining_posts_to_fetch = limit

    uri = _uri_for_posts(user_id, number_of_remaining_posts_to_fetch)

    loop do
      response = Net::HTTP.get(uri)
      json_response = JSON.parse(response, symbolize_names: true)
      posts_data = json_response[:data][:user][:edge_owner_to_timeline_media]

      fetched_posts = posts_data[:edges].map { |edge| edge[:node] }
      posts += fetched_posts

      number_of_remaining_posts_to_fetch -= fetched_posts.count
      page_info = posts_data[:page_info]

      break unless number_of_remaining_posts_to_fetch > 0 && page_info[:has_next_page]

      uri = _uri_for_posts(user_id, number_of_remaining_posts_to_fetch, page_info[:end_cursor])
    end

    posts
  end

  def self._uri_for_posts(user_id, limit, end_cursor = nil)
    variables = {
      id:    user_id,
      first: limit
    }

    variables[:after] = end_cursor if end_cursor

    url_params = "query_hash=#{QUERY_HASH_FOR_POSTS}&variables=#{variables.to_json}"

    URI("#{BASE_URL}/graphql/query/?#{url_params}")
  end
end
