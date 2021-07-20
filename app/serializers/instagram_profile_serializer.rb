# frozen_string_literal: true

class InstagramProfileSerializer < Blueprinter::Base
  identifier :id

  fields :external_id, :user_name, :full_name, :profile_pic_url
end
