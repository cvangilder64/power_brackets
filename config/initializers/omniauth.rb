OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '707977439238496 ', 'e420c6669f2e633a9ea8defb23ff5286'
end
