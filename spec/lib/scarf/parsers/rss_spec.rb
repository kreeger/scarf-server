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

    it 'has a link' do
      expect(ars.link).to eq('http://arstechnica.com')
      expect(wired.link).to eq('http://www.wired.com')
    end

    it 'has a description' do
      expect(ars.description).to eq('The Art of Technology')
      expect(wired.description).to eq('Top Stories')
    end

    it 'has a publish date' do
      expect(ars.publish_date).to be_a(DateTime)
      expect(wired.publish_date).to be_a(DateTime)
      puts ars.publish_date
    end

    it 'has other less-important attributes' do
      expect(ars.language).to eq('en-US')
      expect(wired.language).to eq('en')
      expect(wired.copyright).to eq('2011 Conde Nast Digital. All rights reserved.')
    end

    describe :items do
      it 'will not be empty' do
        expect(ars.items).to be_a(Array)
        expect(wired.items).to be_a(Array)
        expect(ars.items).to_not be_empty
        expect(wired.items).to_not be_empty
      end

      describe :an_item do
        let(:ars_item) { ars.items.first }
        let(:wired_item) { wired.items.first }

        it 'has a title, link, and description' do
          expect(ars_item[:title]).to eq("Ars does Soylent, Day 3: Moderation leads to actual for-real enjoyment")
          expect(wired_item[:title]).to eq("If Volvo Made a Camaro, It'd Look Like This")

          %w(link description pub_date guid).map(&:to_sym).each do |key|
            expect(ars_item[key]).to_not be_empty
            expect(wired_item[key]).to_not be_empty
          end
        end
      end
    end
  end
end
