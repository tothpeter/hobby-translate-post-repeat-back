# frozen_string_literal: true

class InstagramProfile < ApplicationRecord
  validates_presence_of :external_id, :user_name, :full_name, :full_info
end
