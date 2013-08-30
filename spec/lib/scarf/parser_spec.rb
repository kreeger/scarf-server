require 'spec_helper'
require 'scarf'

describe Scarf::Parser do
  def rss(name)
    IO.read(Rails.root.join('spec', 'fixtures', 'rss', name))
  end

  let(:fixtures) do
    Dir[Rails.root.join('spec', 'fixtures', 'rss', '*.*')]
  end

  let(:parsers) do
    fixtures.map { |f| Scarf::Parser.new(rss(f)) }
  end

  describe :initialize do
    it 'takes a data string' do
      parsers.each do |parser|
        expect(parser.data).to_not be_empty
      end
    end
  end

  describe :parse do
    it 'returns a hash' do
      parsers.each do |parser|
        result = parser.parse
        expect(result).to_not be_empty
        expect(result).to be_a(Hash)
      end
    end
  end
end

