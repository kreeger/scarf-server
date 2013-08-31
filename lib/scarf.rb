Dir[File.join(File.dirname(__FILE__), 'scarf', '*.rb')].each { |f| require f }

# Contains all domain-specific code for fetching and parsing
module Scarf
  class Scarf
    def self.fetch_and_parse(urls=[])
      Fetcher.new(urls).fetch.map do |response|
        Parser.new(response.body).parse
      end
    end
  end
end
