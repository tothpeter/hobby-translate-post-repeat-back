# frozen_string_literal: true

describe 'Session', type: :request do
  SIGN_IN_URL  = '/auth/sign_in'
  SIGN_OUT_URL = '/auth/sign_out'

  before(:each) do
    @user         = FactoryBot.create(:user)
    @login_params = {
        email:    @user.email,
        password: @user.password
    }
  end

  describe 'User sign in' do
    context 'when the login params are valid' do
      it 'returns identification data for the client' do
        post SIGN_IN_URL, params: @login_params

        expect(response.headers['uid']).to be_present
        expect(response.headers['client']).to be_present
        expect(response.headers['access-token']).to be_present
        expect(response).to have_http_status(200)
      end
    end

    context 'when login params are invalid' do
      it 'returns unathorized status 401' do
        post SIGN_IN_URL
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'Accessing restricted area 51' do
    context 'when the user is logged in' do
      it 'allows the access' do
        post SIGN_IN_URL, params: @login_params
        @headers = {
          'uid'          => response.headers['uid'],
          'client'       => response.headers['client'],
          'access-token' => response.headers['access-token']
        }

        get '/test-auth', headers: @headers
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is not logged in' do
      it 'denies the access' do
        @headers = {
          'uid'          => 'invalid',
          'client'       => 'invalid',
          'access-token' => 'invalid'
        }

        get '/test-auth', headers: @headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'User sign out' do
    it 'returns status 200' do
      post SIGN_IN_URL, params: @login_params
      @headers = {
        'uid'          => response.headers['uid'],
        'client'       => response.headers['client'],
        'access-token' => response.headers['access-token']
      }

      delete SIGN_OUT_URL, headers: @headers
      expect(response).to have_http_status(200)
    end
  end
end
