require 'spec_helper'
require 'nokogiri'
require 'scarf'

describe Scarf::Parsers::RSS do
  def rss(name)
    IO.read(Rails.root.join('spec', 'fixtures', 'rss', name))
  end

  def sax_parse(file)
    parser = Scarf::Parsers::RSS.new
    noko_sax = Nokogiri::XML::SAX::Parser.new(parser)
    noko_sax.parse(rss(file))
    parser
  end

  let(:ars) { sax_parse('ars.rss') }
  let(:wired) { sax_parse('wired.rss') }

  context :after_parsing do
    it 'contains the result as a hash' do
      expect(ars.result).to be_a(Hash)
      expect(wired.result).to be_a(Hash)
    end

    it 'has a title' do
      expect(ars.title).to eq('Ars Technica')
      expect(wired.title).to eq('Wired Top Stories')
    end
  end

end
