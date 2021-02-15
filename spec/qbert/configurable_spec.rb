# frozen_string_literal: true

RSpec.describe Qbert::Configurable do
  describe "#configurable" do

    subject(:config) { Qbert.configurable }

    context "with modified config vars" do
      let(:queue_url) { "thequeueurl" }
      let(:aws_region) { "us-west-6" }
      let(:access_key_id) { "ABC123" }
      let(:secret_access_key) { "THISISASEKRET" }

      before do
        Qbert.configure do |config|
          config.queue_url = queue_url
          config.region = aws_region
          config.access_key_id = access_key_id
          config.secret_access_key = secret_access_key
        end
      end

      it "is a Qbert::Configurable" do
        expect(config).to be_a Qbert::Configurable
      end

      it "returns the modified queue_url" do
        expect(config.queue_url).to eq(queue_url)
      end

      it "returns the modified aws_region" do
        expect(config.region).to eq(aws_region)
      end

      it "returns the modified access_key_id" do
        expect(config.access_key_id).to eq(access_key_id)
      end

      it "returns the modified secret_access_key" do
        expect(config.secret_access_key).to eq(secret_access_key)
      end
    end
  end
end

