# frozen_string_literal: true

class RawInstagramPostSerializer < Blueprinter::Base
  field :id do |post|
    post[:id]
  end

  field :caption do |post|
    post[:edge_media_to_caption][:edges][0][:node][:text]
  end

  field :is_video do |post|
    post[:is_video]
  end

  field :display_url_big do |post|
    post[:display_url]
  end

  field :display_url_small do |post|
    post[:display_resources][0][:src]
  end

  field :owner do |post|
    {
      id:        post[:owner][:id],
      user_name: post[:owner][:username]
    }
  end
end
