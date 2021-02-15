# frozen_string_literal: true

require "aws-sdk-sqs"

module Qbert
  class Client
    attr_reader :client, :action_result

    def initialize
      @client = Aws::SQS::Client.new region: Qbert.configurable.region,
                                     credentials: Qbert.configurable.credentials
    end

    def put_message(message)
      client.send_message message_params({message_body: message})
    end

    def get_messages()
      result = client.receive_message(message_params({max_number_of_messages: 10}))
      result.messages.map do |message|
        client.delete_message(message_params({receipt_handle: message.receipt_handle}))
        message.body
      end
    end

    private

    def message_params params={}
      {
        queue_url: queue_url
      }.merge(params)
    end

    def queue_url
      Qbert.configurable.queue_url
    end

    def messages
      @action_result.messages.map { |message| message.body }
    end
  end
end
