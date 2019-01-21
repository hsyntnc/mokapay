module Moka
  class << self
    attr_accessor :configuration, :endpoints
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.endpoints ||= Endpoint.new
  end

  class Configuration
    attr_accessor :dealer_code, :username, :password, :env

    def check_key
      Digest::SHA256.hexdigest "#{dealer_code}MK#{username}PD#{password}"
    end

    def test?
      env == 'test'
    end

    def config_hash
      {
          "DealerCode": dealer_code,
          "UserName": username,
          "Password": password,
          "CheckKey": check_key
      }
    end
  end
end