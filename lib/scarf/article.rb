module Scarf
  class Article
    attr_accessor :title, :link, :description, :publish_date, :guid, :attributes

    def initialize(options={})
      @attributes = {}
      options.each do |key, value|
        if self.respond_to?("#{key}=".to_sym)
          self.send("#{key}=".to_sym, value)
        else
          @attributes[key] = value
        end
      end
    end
  end
end
