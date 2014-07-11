OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '707977439238496 ', 'e420c6669f2e633a9ea8defb23ff5286'
    provider :google_oauth2, ENV["408156623576-9njv6khkt2uqp6nvc3k3b51hn9lmiv2c.apps.googleusercontent.com"], ENV["a4h-n3PY1OiRjHIBHzfi0Xtp"]
    provider :twitter, "OZTTQp8bxeCuJAvYLPsYWrzk6", "gTZby0vCW9PDaFYV9XitcaBhDSjH53H9tJHma2v1voxsuhWDRj"

end
