# frozen_string_literal: true

module Instagram
  def self.import_profile!(user_name)
    profile_info = Instagram::PublicWebClient.fetch_profile_info(user_name)

    new_profile_params = {
      external_id:     profile_info[:id],
      user_name:       user_name,
      full_name:       profile_info[:full_name],
      profile_pic_url: profile_info[:profile_pic_url],
      full_info:       profile_info
    }

    InstagramProfile.create!(new_profile_params)
  end
end
