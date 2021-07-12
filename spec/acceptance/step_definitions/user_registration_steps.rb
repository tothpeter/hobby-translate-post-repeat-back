# frozen_string_literal: true

steps_for :user_registration do
  step 'no user in the system' do
    expect(User.count).to eq(0)
  end

  step 'the user sends a registration request' do
    signup_params = {
      email:                 'user@example.com',
      password:              '12345678',
      password_confirmation: '12345678'
    }

    post '/auth', params: signup_params
  end

  step 'create a new user' do
    expect(User.last.email).to eq('user@example.com')
  end

  step 'return the necesary auth data for the client' do
    expect(response.headers['uid']).to be_present
    expect(response.headers['client']).to be_present
    expect(response.headers['access-token']).to be_present
    expect(response).to have_http_status(200)
  end

  step 'the user requests a restricted resource' do
    @headers = {
      'uid'          => response.headers['uid'],
      'client'       => response.headers['client'],
      'access-token' => response.headers['access-token']
    }

    get '/test-auth', headers: @headers
  end

  step 'the access is granted' do
    expect(response).to have_http_status(200)
  end
end
