# Module for handling encrypting/decrypting values
module TokenManagement
  extend ActiveSupport::Concern

  included do
  end

  # Things exposed to the included class as class methods
  module ClassMethods
    def sodium_secret
      ENV["SIMPLE_BOX_SECRET"] ||
        raise("No SIMPLE_BOX_SECRET environmental variable set")
    end

    def sodium_secret_bytes
      sodium_secret.unpack("m0").first
    end
  end

  def sodium_reset
    @sodium_simple_box = nil
  end

  def sodium_simple_box
    @sodium_simple_box ||=
      RbNaCl::SimpleBox.from_secret_key(self.class.sodium_secret_bytes)
  end

  def sodium_encrypt_value(value)
    return if value.blank?
    Base64.encode64(sodium_simple_box.encrypt(value)).chomp
  end

  def sodium_decrypt_value(value)
    sodium_simple_box.decrypt(Base64.decode64(value))
  rescue RbNaCl::CryptoError, NoMethodError
    nil
  end
end
