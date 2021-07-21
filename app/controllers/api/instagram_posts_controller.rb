# frozen_string_literal: true

class Api::InstagramPostsController < ApplicationController
  before_action :authenticate_api_user!

  def latest
    posts = []

    InstagramProfile.all.each do |profile|
      fetched_posts = Instagram::PublicWebClient.latest_posts_by_user_id(profile.external_id, limit: 10)
      posts += RawInstagramPostSerializer.render_as_hash(fetched_posts)
    end

    render json: posts
  end
end
