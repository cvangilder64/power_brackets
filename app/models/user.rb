class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :timeoutable and

    validates :name, presence: true
    validates :last_name, presence: true, :unless => :provider?
    validates :email, presence: true, :unless => :provider?
    has_secure_password

    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :lockable, :omniauthable,
        :omniauth_providers => [:facebook]

    validates :name, presence: true
    validates :last_name, presence: true    , :unless => :provider?
    validates :email, presence: true        , :unless => :provider?

    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.name = auth.info.name   # assuming the user model has a name
            user.provider = auth.provider
            user.uid = auth.uid
            user.oauth_token = auth.credentials.token
#            user.image = auth.info.image # assuming the user model has an image

            if auth.credentials.expires_at
                user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            end
            user.save!
        end
    end

    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
                user.email = data["email"] if user.email.blank?
            end
        end
    end
end
