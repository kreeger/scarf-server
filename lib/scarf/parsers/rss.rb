require 'scarf/feed'
require 'scarf/article'

module Scarf::Parsers
  # Handles parsing RSS in the SAX school-of-thought by being passed to Nokogiri
  # during its parsing process. Tracks RSS-specific tags and items and things.
  class RSS < Nokogiri::XML::SAX::Document
    attr_reader :feed

    def initialize
      @result = {
        title: nil,
        link: nil,
        description: nil,
        language: nil,
        pub_date: nil,
        last_build_date: nil,
        ttl: nil,
        copyright: nil,
        items: [],
      }
    end

    def start_document
      # This space intentionally left blank.
    end

    def end_document
      @feed = Scarf::Feed.new(@result)

      # Dates *should* conform to RFC 822. If I encounter more formats, I'll
      # split this out into a more robust parsing method.
      if @result[:pub_date]
        @feed.publish_date = DateTime.parse(@result[:pub_date])
      end

      if @result[:last_build_date]
        @feed.last_build_date = DateTime.parse(@result[:last_build_date])
      end
    end

    def start_element(name, attributes=[])
      @element = { cdata: nil, characters: nil }
      if name == 'item'
        @item = {}
      end
    end

    def cdata_block(string)
      @element[:cdata] ||= String.new
      @element[:cdata] << string
    end

    def characters(string)
      @element[:characters] ||= String.new
      @element[:characters] << string.gsub(/\s{2,}/, ' ')
    end

    def end_element(name)
      content = @element[:characters] || @element[:cdata]
      content = content.strip if content
      # I wish to thank ActiveSupport for its support
      fixed_name = name.underscore.to_sym
      case fixed_name
      when :category
        @item[fixed_name] ||= []
        @item[fixed_name] << content
      when :item
        publish_date = @item[:pub_date]
        if publish_date
          publish_date = DateTime.parse(publish_date)
          @item.delete(:pub_date)
        end
        article = Scarf::Article.new(@item)
        article.publish_date = publish_date
        @result[:items] << article
      else
        if @result.keys.include?(fixed_name) && @result[fixed_name].nil?
          @result[fixed_name] = content
        elsif @item
          @item[fixed_name] = content
        end
      end
    end
  end
end
