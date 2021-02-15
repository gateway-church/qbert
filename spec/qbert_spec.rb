RSpec.describe Qbert do
  it "has a version number" do
    expect(Qbert::VERSION).not_to be nil
  end

  describe "delegating to a client" do
    let(:queue_url) { "thisisaqurl" }
    let(:client) { double(send_message: {result: "Hello"}, receive_message: {}, delete_message: {}) }

    before do
      Qbert.configure { |config| config.queue_url = queue_url }
      allow(Aws::SQS::Client).to receive(:new).and_return(client)
    end

    subject(:qbert_client) { Qbert.client }

    it { is_expected.to be_a Qbert::Client }

    describe "#put_message" do
      it "calls Qbert::Client.put_message" do
        expect(Qbert.put_message("Hola")).to eq(Qbert::Client.new.put_message("Hola"))
      end
    end

    describe "#get_messages" do
      let(:receipt_handle) { "AQEBur2IJZIwx7HlKp2PQtMxce9HsjKvRB" }
      let(:msg_body) { "This is a test message" }
      let(:message) { double(:message, receipt_handle: receipt_handle, body: msg_body) }
      let(:result) { double(:result, messages: [message]) }
      it "calls Qbert::Client.get_message" do
        allow(client).to receive(:receive_message).and_return(result)
        expect(Qbert.get_messages).to eq(Qbert::Client.new.get_messages)
      end
    end
  end
end
