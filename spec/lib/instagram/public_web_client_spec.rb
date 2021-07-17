# frozen_string_literal: true

describe Instagram::PublicWebClient do
  vcr_options = { cassette_name: 'instagram/profile/fetch', match_requests_on: [:path] }

  describe 'Fetching plain profile data', vcr: vcr_options do
    it 'it returns the public profile as a hash' do
      profile_info = described_class.fetch_profile_info('captain_rebel_tv')

      expect(profile_info[:full_name]).to eq('Captain Rebel')
    end
  end

  vcr_options = { cassette_name: 'instagram/profile/posts_last_130', match_requests_on: [:path] }

  describe 'Fetching limited posts of a given profile', vcr: vcr_options do
    it 'returns the posts' do
      posts = described_class.fetch_latest_posts_by_user_name('captain_rebel_tv', limit: 130)

      expect(posts.count).to eq(130)
      expect(posts.first[:id]).to eq('2618499570550571667')
      expect(posts.last[:id]).to eq('2404465245923214590')
    end
  end
end
