require 'spec_helper'
require 'scarf'

describe Scarf::Fetcher do
  let(:uris) do
    [
      'http://feeds.wired.com/wired/index',
      'http://feeds.arstechnica.com/arstechnica/index'
    ]
  end

  before(:each) { @fetcher = Scarf::Fetcher.new uris }

  describe :initialize do
    it 'takes a URI array and options, generates request objects' do
      expect(@fetcher.requests.first).to be_a(Typhoeus::Request)
      expect(@fetcher.requests.count).to equal(uris.count)
    end
  end

  describe :fetch do
    before(:each) { @result = @fetcher.fetch }
    it 'returns the results of a fetch', vcr: { record: :new_episodes } do
      expect(@result).to be_a(Array)
      expect(@result).to_not be_empty
      expect(@result.count).to equal(uris.count)
      expect(@result.first.body).to be_a(String)
      expect(@result.first.body).to_not be_empty
      expect(@result.first.response_code).to equal(200)
    end
  end
end

