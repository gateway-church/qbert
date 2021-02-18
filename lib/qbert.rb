# frozen_string_literal: true

require "qbert/version"
require "qbert/configurable"
require "qbert/client"

module Qbert
  class Error < StandardError; end

  class << self
    def put_message message
      client.put_message message
    end

    def get_messages
      client.get_messages
    end

    def client
      Client.new
    end
  end
end
