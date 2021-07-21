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

    trait :existing1 do
      external_id { '3231033489' }
      user_name { 'captain_rebel_tv' }
    end

    trait :existing2 do
      external_id { '1704794933' }
      user_name { 'vegan_sarcasm' }
    end
  end
end
