# frozen_string_literal: true

describe Instagram::PublicWebClient do
  vcr_options = { cassette_name: 'instagram/profile/fetch', match_requests_on: [:path] }

  describe 'Fetching plain profile data', vcr: vcr_options do
    it 'it returns the public profile as a hash' do
      profile_data = described_class.fetch_profile('captain_rebel_tv')

      expect(profile_data[:graphql][:user][:full_name]).to eq('Captain Rebel')
    end
  end

  vcr_options = { cassette_name: 'instagram/profile/posts_last_12', match_requests_on: [:path] }

  describe 'Fetching the last 12 posts of a given profile', vcr: vcr_options do
    it 'returns the posts' do
      posts = described_class.fetch_latest_posts_of('captain_rebel_tv')

      expect(posts.count).to eq(12)
      expect(posts.first[:id]).to eq('2618499570550571667')
    end
  end
end
