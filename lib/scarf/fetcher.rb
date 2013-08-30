module Scarf

  # Handles all inbound data retrieval for Scarf.
  class Fetcher
    attr_reader :requests

    # Initializes a fetcher with a URI to use while fetching, and options.
    #
    # @param [Array] uris The string URIs to use when grabbing a feed.
    # @param [Hash] opts A hash of options.
    # @return An instance of this class.
    def initialize(uris, opts={})
      @requests = uris.map do |u|
        Typhoeus::Request.new(u, method: :get, followlocation: true)
      end
      @runner = Typhoeus::Hydra.hydra
    end

    # TODO: YAGNI or test
    def queue_uri(uri, callback)
      request = Typhoeus::Request.new(uri, method: :get)
      request.on_complete(callback)
      @requests << request
    end

    # Makes the call to grab the data (singular request).
    # @return The data, if successful
    def fetch
      @requests.each { |request| @runner.queue request }
      @runner.run
      @requests.map { |request| request.response }
    end
  end
end
