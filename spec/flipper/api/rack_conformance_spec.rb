RSpec.describe 'Flipper::Api rack conformance' do
  # Wraps the real API app in Rack::Lint, which enforces the Rack spec for the
  # installed rack version. Under rack 3 this fails on capitalized response
  # header keys.
  let(:app) do
    inner = Flipper::Api.app(flipper)
    Rack::Lint.new(inner)
  end

  it 'serves a features request without violating the rack spec' do
    flipper[:stats].enable
    get '/features'
    expect(last_response.status).to be(200)
  end
end
