require 'active_support/concern'

module AuthenticationToken
  extend ActiveSupport::Concern

  included do
    has_secure_token :auth_token
    before_create :set_access_token
  end

  class_methods do
  end

  private

    def set_access_token
      self.auth_token = generate_token
    end

    def generate_token
      loop do
        token = SecureRandom.uuid.gsub(/\-/,'')
        break token unless User.where(auth_token: token).exists?
      end
    end
end
