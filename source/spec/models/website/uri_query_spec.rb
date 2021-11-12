# frozen_string_literal: true

require 'spec_helper'

describe Website::UriQuery, type: :model do
  subject(:query) { described_class.new(scope, url) }

  let(:url)      { "http://www.google.com" }
  let(:uri)      { URI.parse(url) }
  let(:protocol) { uri.scheme }
  let(:domain)   { uri.host }
  let(:port)     { uri.port }
  let(:scope)    { Website.all }

  let!(:website) do
    create(:website, protocol: protocol, domain: domain, port: port)
  end

  context "when all attributes match" do
    it "returns the wanted queried site" do
      expect(query.website).to include(website)
    end
  end
end
