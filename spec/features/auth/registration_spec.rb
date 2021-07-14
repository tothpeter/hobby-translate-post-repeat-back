# frozen_string_literal: true

describe 'User registration', type: :request do
  SIGN_UP_URL = '/api/auth/'

  SIGNUP_PARAMS = {
    email:                 'user@example.com',
    password:              '12345678',
    password_confirmation: '12345678'
  }

  context 'when the signup params are valid' do
    it 'returns identification data for the client' do
      post SIGN_UP_URL, params: SIGNUP_PARAMS

      expect(response.headers['uid']).to be_present
      expect(response.headers['client']).to be_present
      expect(response.headers['access-token']).to be_present
      expect(response).to have_http_status(200)
    end

    it 'creates a new user' do
      expect{
        post SIGN_UP_URL, params: SIGNUP_PARAMS
      }.to change(User, :count).by(1)

      expect(User.last.email).to eq(SIGNUP_PARAMS[:email])
    end
  end

  context 'when the signup params are invalid' do
    it 'returns unprocessable entity' do
      post SIGN_UP_URL

      expect(response).to have_http_status(422)
    end
  end
end
