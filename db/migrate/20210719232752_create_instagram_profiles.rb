# frozen_string_literal: true

class CreateInstagramProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :instagram_profiles do |t|
      t.string :external_id
      t.string :user_name
      t.string :full_name
      t.string :number_of_posts
      t.string :number_of_followers
      t.string :profile_pic_url
      t.json :full_info

      t.timestamps
    end
  end
end
