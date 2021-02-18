# frozen_string_literal: true

RSpec.describe Qbert::Client do
  let(:client) { double(send_message: {}, receive_message: {}, delete_message: {}) }
  let(:queue_url) { "thisisaqurl" }

  subject { Qbert::Client.new }

  before do
    Qbert.configure { |config| config.queue_url = queue_url }
    allow(Aws::SQS::Client).to receive(:new).and_return(client)
  end

  describe ".put_message" do
    let(:message) { "Hello from Texas" }
    let(:msg_hash) { { message_body: message, queue_url: queue_url } }

    it "calls send_message" do
      allow(subject.client).to receive(:send_message).with(msg_hash)
      subject.put_message message
      expect(subject.client).to have_received(:send_message).with(msg_hash)
    end
  end

  describe ".get_messages" do
    let(:max_msgs) { 10 }
    let(:message_params) do
      { max_number_of_messages: max_msgs, queue_url: queue_url }
    end
    let(:receipt_handle) { "AQEBur2IJZIwx7HlKp2PQtMxce9HsjKvRB" }
    let(:msg_body) { "This is a test message" }
    let(:message) { double(:message, receipt_handle: receipt_handle, body: msg_body) }
    let(:result) { double(:result, messages: [message]) }
    let(:delete_params) do
      { receipt_handle: receipt_handle, queue_url: queue_url }
    end

    before do
      allow(subject.client).to receive(:receive_message).with(message_params).and_return(result)
      allow(subject.client).to receive(:delete_message).with(delete_params)
    end

    it "calls receive_message" do
      subject.get_messages
      expect(subject.client).to have_received(:receive_message).with(message_params)
    end

    it "calls delete_message" do
      subject.get_messages
      expect(subject.client).to have_received(:delete_message).with(delete_params)
    end

    it "returns an array" do
      expect(subject.get_messages).to be_an Array
    end

    it "returns an array of message bodies" do
      expect(subject.get_messages).to eq([msg_body])
    end
  end
end
