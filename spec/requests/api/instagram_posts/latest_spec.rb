# frozen_string_literal: true

describe 'GET /api/instagram_posts/latest' do
  vcr_options = { cassette_name: 'instagram/public_web/posts_latest_10_of_2_existing_profiles', match_requests_on: [:path] }

  it 'returns the last 10 posts of the followed IG profiles', vcr: vcr_options do
    FactoryBot.create(:instagram_profile, :existing1)
    FactoryBot.create(:instagram_profile, :existing2)
    auth_headers = FactoryBot.create(:user).create_new_auth_token

    get '/api/instagram_posts/latest', headers: auth_headers

    expect(response).to be_successful
    expect(json_response.count).to eq(20)

    latest_post_of_first_profile = json_response[0]

    expect(latest_post_of_first_profile[:id]).to eq('2618499570550571667')
    expect(latest_post_of_first_profile[:owner][:user_name]).to eq('captain_rebel_tv')

    latest_post_of_second_profile = json_response[10]

    expect(latest_post_of_second_profile[:id]).to eq('2622804668089325057')
    expect(latest_post_of_second_profile[:owner][:user_name]).to eq('vegan_sarcasm')
  end

  it 'requires authentication' do
    get '/api/instagram_posts/latest'
    expect(response).to have_http_status(401)
  end
end
