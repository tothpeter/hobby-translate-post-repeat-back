# frozen_string_literal: true

describe Instagram::Profile::Post do
  vcr_options = { cassette_name: 'instagram/profile/posts_last_12', match_requests_on: [:path] }

  describe 'Fetching the last 12 posts of a given profile', vcr: vcr_options do
    it 'returns the posts' do
      posts = described_class.latest_posts('captain_rebel_tv')

      expect(posts.count).to eq(12)
      expect(posts.first[:id]).to eq('2618499570550571667')
    end
  end
end
