RSpec.describe 'Flipper::UI rack conformance' do
  # Wraps the real UI app in Rack::Lint, which enforces the Rack spec for the
  # installed rack version. Under rack 3 this fails on capitalized response
  # header keys.
  let(:app) do
    inner = Flipper::UI.app(flipper) do |builder|
      # Rack 3 requires secrets to be at least 64 bytes
      builder.use Rack::Session::Cookie, secret: 'x' * 64
    end
    Rack::Lint.new(inner)
  end

  let(:token) do
    if Rack::Protection::AuthenticityToken.respond_to?(:random_token)
      Rack::Protection::AuthenticityToken.random_token
    else
      'a'
    end
  end
  let(:session) do
    { :csrf => token, 'csrf' => token, '_csrf_token' => token }
  end

  it 'serves the features page without violating the rack spec' do
    flipper[:stats].enable
    get '/features'
    expect(last_response.status).to be(200)
  end

  it 'serves a static asset without violating the rack spec' do
    get '/css/application.css'
    expect(last_response.status).to be(200)
  end

  it 'serves a redirect without violating the rack spec' do
    post '/features',
         { value: 'conformance_flag', authenticity_token: token },
         'rack.session' => session
    expect(last_response.status).to be(302)
  end

  it 'serves an export without violating the rack spec' do
    post '/settings/export', { authenticity_token: token }, 'rack.session' => session
    expect(last_response.status).to be(200)
  end
end
