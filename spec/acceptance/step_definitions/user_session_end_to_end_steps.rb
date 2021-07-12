# frozen_string_literal: true

steps_for :user_session_end_to_end do
  attr_reader :current_user, :auth_headers

  step 'a registered user' do
    @current_user = create(:user)
  end

  step 'the user is not signed in' do
  end

  step 'he cannot access the restricted area' do
    get '/test-auth'
    expect(response).to have_http_status(401)
  end

  step 'the user signs in' do
    login_params = {
      email:    @current_user.email,
      password: @current_user.password
    }

    post '/auth/sign_in', params: login_params
    expect(response).to have_http_status(200)
  end

  step 'he can access the restricted area' do
    @auth_headers = {
      'uid'          => response.headers['uid'],
      'client'       => response.headers['client'],
      'access-token' => response.headers['access-token']
    }

    get '/test-auth', headers: @auth_headers

    expect(response).to have_http_status(200)
  end

  step 'the user signs out' do
    delete '/auth/sign_out', headers: @auth_headers
    expect(response).to have_http_status(200)
  end

  step 'he cannot access the restricted area anymore' do
    get '/test-auth', headers: @auth_headers
    expect(response).to have_http_status(401)
  end
end
