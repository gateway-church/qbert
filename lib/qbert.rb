# frozen_string_literal: true

require "qbert/version"
require "qbert/configurable"
require "qbert/client"

module Qbert
  class Error < StandardError; end

  class << self
    def put_message message, queue_url = nil
      client(queue_url).put_message message
    end

    def get_messages queue_url = nil
      client(queue_url).get_messages
    end

    def client queue_url = nil
      Client.new queue_url
    end
  end
end
