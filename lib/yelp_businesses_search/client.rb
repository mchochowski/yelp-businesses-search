# frozen_string_literal: true

module YelpBusinessesSearch
  class Client
    def initialize(api_key:, host: nil)
      @config = {
        api_key: api_key,
        host: host || 'https://api.yelp.com/v3'
      }
    end

    def lookup(params)
      SearchEndpoint.new(params, @config).call
    end

    def get_details(id)
      # TODO: implement
      # DetailsEndpoint.new(id, @config).call
    end
  end
end
