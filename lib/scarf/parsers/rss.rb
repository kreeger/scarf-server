module Scarf::Parsers
  # Handles parsing RSS in the SAX school-of-thought by being passed to Nokogiri
  # during its parsing process. Tracks RSS-specific tags and items and things.
  class RSS < Nokogiri::XML::SAX::Document
    attr_reader :result, :publish_date, :last_build_date

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
      # Dates *should* conform to RFC 822. If I encounter more formats, I'll
      # split this out into a more robust parsing method.
      if @result[:pub_date]
        @publish_date = DateTime.parse(@result[:pub_date])
      end

      if @result[:last_build_date]
        @last_build_date = DateTime.parse(@result[:last_build_date])
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
      @element[:characters] << string
    end

    def end_element(name)
      content = @element[:characters] || @element[:cdata]
      content = content.strip if content
      case name
      when 'category'
        @item[name.to_sym] ||= []
        @item[name.to_sym] << content
      when 'item'
        @result[:items] << @item
      else
        # I wish to thank ActiveSupport for its support
        fixed_name = name.underscore.to_sym
        if @result.keys.include?(fixed_name) && @result[fixed_name].nil?
          @result[fixed_name] = content
        elsif @item
          @item[fixed_name] = content
        end
      end
    end

    def respond_to_missing?(name, include_private = false)
      @result.keys.include?(name) || super
    end

    def method_missing(name, *args, &block)
      if @result.keys.include?(name)
        @result[name]
      else
        super
      end
    end
  end
end
