require 'nokogiri'

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
    # @return [Hash] Returns an feed hash.
    def parse_rss
      noko = Nokogiri::XML.parse(@data)
      debugger
      {
        title: noko.css('channel > title').text,
      }
    end
  end
end
