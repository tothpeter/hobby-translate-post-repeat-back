# frozen_string_literal: true

describe 'GET /image-proxy' do
  vcr_options = { cassette_name: 'image-proxy', match_requests_on: [:path] }

  it 'returns the requested image from Instagram', vcr: vcr_options do
    requested_image_url = 'https://instagram.feoh3-1.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/217408920_1491107024571850_6338419401501661422_n.jpg?_nc_ht=instagram.feoh3-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=UJRgZsf_KkIAX_AO9Iv&edm=APU89FABAAAA&ccb=7-4&oh=9e7e6c1afddd65cec3534f7957a4478d&oe=61006AEA&_nc_sid=86f79a'
    encoded_url = ERB::Util.url_encode(Base64.encode64(requested_image_url))

    get "/image-proxy/#{encoded_url}"

    expect(response).to be_successful
    expect(response.headers['Content-Type']).to eq('image/jpeg')
    expect(response.headers['Content-Disposition']).to be_nil
    expect(response.body).to be_present
  end
end
