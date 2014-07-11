class User < ActiveRecord::Base

    validates :name, presence: true
    validates :last_name, presence: true, :unless => :provider?
    validates :email, presence: true, :unless => :provider?
    has_secure_password

    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.password = SecureRandom.hex
            user.save!
        end
    end
end
