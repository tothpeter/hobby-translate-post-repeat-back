# frozen_string_literal: true

FactoryBot.define do
  factory :instagram_profile do
    external_id { 'external_id' }
    user_name { 'user_name' }
    full_name { 'Full Name' }
    profile_pic_url { 'profile_pic_url' }
    full_info do
      {
        graphql: {
          user: {
            id: 'external_id'
          }
        }
      }
    end
  end
end
