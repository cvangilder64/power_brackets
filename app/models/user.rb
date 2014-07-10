class User < ActiveRecord::Base

    validates :name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    has_secure_password

end
