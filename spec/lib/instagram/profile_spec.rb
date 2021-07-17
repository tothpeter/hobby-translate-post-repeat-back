# frozen_string_literal: true

describe Instagram::Profile do
  vcr_options = { cassette_name: 'instagram/profile/fetch', match_requests_on: [:path] }

  describe 'Fetching plain profile data', vcr: vcr_options do
    it 'it returns the public profile as a hash' do
      profile_json = described_class.fetch_plain_data('captain_rebel_tv')

      expect(profile_json[:graphql][:user][:full_name]).to eq('Captain Rebel')
    end
  end
end
