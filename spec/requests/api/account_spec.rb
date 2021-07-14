# frozen_string_literal: true

describe 'GET /api/account' do
  it 'returns the signed in user' do
    current_user = FactoryBot.create(:user)
    auth_headers = current_user.create_new_auth_token

    get '/api/account', headers: auth_headers

    expect(response).to have_http_status(200)
    expect(json_response[:email]).to eq(current_user.email)
  end
end
