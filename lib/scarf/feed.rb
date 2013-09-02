module Scarf
  # Stores data regarding an RSS item (article).
  class Feed
    attr_accessor :title, :link, :description, :language, :publish_date
    attr_accessor :last_build_date, :ttl, :copyright, :items

    def initialize(options={})
      options.each do |key, value|
        if self.respond_to?("#{key}=".to_sym)
          self.send("#{key}=".to_sym, value)
        end
      end

      # If items didn't come in, setup an empty array
      @items ||= Array.new
    end
  end
end
