require 'nokogiri'
Dir[File.join(File.dirname(__FILE__), 'parsers', '*.rb')].each { |f| require f }

module Scarf

  # Handles all parsing logic. Delegates parsing functionality to various
  # methods.
  class Parser
    attr_reader :data, :content_type

    # Initializes a parser with a chunk of text.
    def initialize(data)
      @data = data
      @content_type = :rss # TODO: make this dynamic
    end

    # Parses and returns the data. Delegates to various content-type specific
    # methods to do the bidding.
    #
    # @return [Hash] Returns an feed hash.
    def parse
      self.send("parse_#{@content_type}".to_sym)
    end

    # Handles RSS-specific parsing. TODO: after exploring, use SAX-based parsing
    #
    # @return [Scarf::Feed] Returns an feed hash.
    def parse_rss
      parser = Parsers::RSS.new
      noko_sax = Nokogiri::XML::SAX::Parser.new(parser)
      noko_sax.parse(@data)
      parser.feed
    end
  end

  # Inner module that contains all of the parsers in use by Scarf. See the
  # parsers directory for class definitions.
  module Parsers; end
end
