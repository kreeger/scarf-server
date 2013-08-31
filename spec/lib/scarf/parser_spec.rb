require 'spec_helper'
require 'scarf'

describe Scarf::Parser do
  let(:parser) do
    Scarf::Parser.new("<xml></xml>")
  end

  describe :initialize do
    it 'takes a data string' do
      expect(parser.data).to_not be_empty
    end
  end

  describe :parse do
    it 'calls the appropriate method' do
      expect(parser).to receive(:parse_rss)
      result = parser.parse
    end

    it 'returns a hash' do
      expect(parser.parse).to be_a(Hash)
      expect(parser.parse).to_not be_nil
    end
  end
end

