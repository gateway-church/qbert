# frozen_string_literal: true

require "aws-sdk-sqs"

module Qbert
  class Configurable
    attr_accessor :queue_url, :region, :access_key_id, :secret_access_key

    def credentials
      (@credentials || aws_credentials)
    end

    private

    def aws_credentials
      @aws_credentials ||= Aws::Credentials.new @access_key_id, @secret_access_key
    end
  end

  def self.configurable
    @configurable ||= Configurable.new
  end

  def self.configurable=(config)
    @configurable = config
  end

  def self.configure
    yield(configurable)
  end
end
