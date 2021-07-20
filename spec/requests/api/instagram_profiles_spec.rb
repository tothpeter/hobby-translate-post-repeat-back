# frozen_string_literal: true

describe '/api/instagram_profiles' do
  describe 'GET /index' do
    it 'returns the existing records' do
      FactoryBot.create_list(:instagram_profile, 2)
      auth_headers = FactoryBot.create(:user).create_new_auth_token

      get '/api/instagram_profiles', headers: auth_headers

      expect(response).to be_successful
      expect(json_response.count).to eq(2)
      expect(json_response.last[:id]).to eq(2)
    end

    it 'requires authentication' do
      get '/api/instagram_profiles'
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET /show' do
    it 'returns the requested record' do
      instagram_profile = FactoryBot.create(:instagram_profile)
      auth_headers = FactoryBot.create(:user).create_new_auth_token

      get "/api/instagram_profiles/#{instagram_profile.id}", headers: auth_headers

      expect(response).to have_http_status(200)
      expect(json_response[:id]).to eq(instagram_profile.id)
    end
  end

  describe 'POST /import' do
    context 'with valid parameters' do
      vcr_options = { cassette_name: 'instagram/public_web/profile', match_requests_on: [:path] }

      it 'creates a new InstagramProfile record using the data from Instagram', vcr: vcr_options do
        auth_headers = FactoryBot.create(:user).create_new_auth_token

        request_params = {
          user_name: 'captain_rebel_tv'
        }

        post '/api/instagram_profiles/import', params: request_params, headers: auth_headers

        new_instagram_profile = InstagramProfile.last

        expect(response).to have_http_status(201)
        expect(new_instagram_profile.user_name).to eq('captain_rebel_tv')
        expect(new_instagram_profile.external_id).to eq('3231033489')

        expect(json_response[:user_name]).to eq('captain_rebel_tv')
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        auth_headers = FactoryBot.create(:user).create_new_auth_token

        post '/api/instagram_profiles/import', headers: auth_headers

        expect(response).to have_http_status(422)
        expect(json_response[:errors][:user_name]).to be_present
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested InstagramProfile and returns it' do
        auth_headers = FactoryBot.create(:user).create_new_auth_token
        instagram_profile = FactoryBot.create(:instagram_profile)

        request_params = {
          params: {
            instagram_profile: {
              external_id: 'NEW_EXTERNAL_ID'
            }
          },
          headers: auth_headers
        }

        patch "/api/instagram_profiles/#{instagram_profile.id}", request_params

        instagram_profile.reload
        expect(instagram_profile.external_id).to eq('NEW_EXTERNAL_ID')
        expect(json_response[:external_id]).to eq('NEW_EXTERNAL_ID')
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the instagram_profile' do
        auth_headers = FactoryBot.create(:user).create_new_auth_token
        instagram_profile = FactoryBot.create(:instagram_profile)

        request_params = {
          params: {
            instagram_profile: {
              external_id: ''
            }
          },
          headers: auth_headers
        }

        patch "/api/instagram_profiles/#{instagram_profile.id}", request_params

        instagram_profile.reload
        expect(instagram_profile.external_id).to eq('external_id')
        expect(json_response[:errors][:external_id]).to be_present
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested instagram_profile' do
      instagram_profile = FactoryBot.create(:instagram_profile)
      auth_headers = FactoryBot.create(:user).create_new_auth_token

      delete "/api/instagram_profiles/#{instagram_profile.id}", headers: auth_headers

      expect(response).to have_http_status(204)
      expect(InstagramProfile.count).to eq(0)
    end
  end
end
