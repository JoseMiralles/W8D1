class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum:6, allow_nil: true}
    validates :password_digest, presence: true

    attr_reader :password

    after_initialize :ensure_session_token

    has_many :subs,
        foreign_key: :moderator_id,
        class_name: :Sub

    def password=(pass)
        @password = pass
        self.password_digest = BCrypt::Password.create(pass)
    end

    def is_password?(pass)
        BCrypt::Password.new(self.password_digest).is_password?(pass)
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::base64
        self.save!
        self.session_token
    end

    def self.find_by_credentials(u,p)
        user = self.find_by(username: u)

        if user && user.is_password?(p)
            return user
        end

        return nil
    end

end