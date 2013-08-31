module Scarf::Parsers
  class RSS < Nokogiri::XML::SAX::Document
    attr_reader :result

    def initialize
      @result = {
        title: nil,
        link: nil,
        description: nil,
        language: nil,
        pubDate: nil,
        items: [],
      }
    end

    def start_document
      # This space intentionally left blank.
    end

    def end_document
      # This space intentionally left blank.
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
        fixed_name = name.gsub(':', '_').to_sym
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
