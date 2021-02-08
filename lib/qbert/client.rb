# frozen_string_literal: true

require "aws-sdk-sqs"

module Qbert
  class Client
    attr_reader :client, :action_result

    def initialize
      @client = Aws::SQS::Client.new region: Qbert.configurable.region,
                                     credentials: Qbert.configurable.credentials
    end

    def put_message(message = "")
      @action_result = client.send_message message_hash(message)
    end

    private

    def message_hash(message)
      {
        queue_url: Qbert.configurable.queue_url,
        message_body: message,
      }
    end
  end
end
