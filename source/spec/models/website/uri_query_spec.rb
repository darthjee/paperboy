# frozen_string_literal: true

require 'spec_helper'

describe Website::UriQuery, type: :model do
  subject(:query) { described_class.new(scope, url) }

  describe "#websites" do
    let(:url)      { "http://www.google.com" }
    let(:uri)      { URI.parse(url) }
    let(:protocol) { uri.scheme }
    let(:domain)   { uri.host }
    let(:port)     { uri.port }
    let(:scope)    { Website.all }

    let!(:website) do
      create(:website, protocol: protocol, domain: domain, port: port)
    end
    let!(:other_website) { create(:website) }

    context "when all attributes match" do
      it "returns the wanted queried site" do
        expect(query.websites).to include(website)
      end

      it "does not return unwanted website" do
        expect(query.websites).not_to include(other_website)
      end

      context "other site matches the domain" do
        let!(:other_website) do
          create(:website, domain: domain, protocol: :https, port: 8080)
        end

        it "does not return unwanted website" do
          expect(query.websites).not_to include(other_website)
        end
      end

      context "other site matches the domain and port" do
        let!(:other_website) do
          create(:website, domain: domain, protocol: :https, port: port)
        end

        it "does not return unwanted website" do
          expect(query.websites).not_to include(other_website)
        end
      end

      context "other site matches the domain and protocol" do
        let!(:other_website) do
          create(:website, domain: domain, protocol: :http, port: 8080)
        end

        it "does not return unwanted website" do
          expect(query.websites).not_to include(other_website)
        end
      end
    end

    context "when website was defined without a protocol" do
      let(:protocol) { nil }

      it "returns the wanted queried site" do
        expect(query.websites).to include(website)
      end
    end

    context "when website was defined without a port" do
      let(:port) { nil }

      it "returns the wanted queried site" do
        expect(query.websites).to include(website)
      end
    end

    context "when website was defined without a port or protocol" do
      let(:port)     { nil }
      let(:protocol) { nil }

      it "returns the wanted queried site" do
        expect(query.websites).to include(website)
      end
    end

    context "when url is for https and non standard port" do
      let(:url) { "https://www.google.com:9000" }

      let!(:other_website) do
        create(:website, protocol: protocol, port: port)
      end

      it "returns the wanted queried site" do
        expect(query.websites).to include(website)
      end

      it "does not return unwanted website" do
        expect(query.websites).not_to include(other_website)
      end
    end
  end
end
