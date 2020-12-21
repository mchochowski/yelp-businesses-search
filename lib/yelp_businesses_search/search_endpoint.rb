# frozen_string_literal: true

module YelpBusinessesSearch
  class SearchEndpoint
    METHOD = 'GET'
    PATH = '/businesses/search'

    def initialize(params, config)
      @params = params
      @config = config
    end

    def call
      RestClient::Request.execute(request_message)
    rescue RestClient::ExceptionWithResponse => e
      { error: 'error connecting to yelp',
        original_response: JSON.parse(e.response) }.to_json
    end

    private

    def payload
      {
        term: @params[:query],
        latitude: @params[:latitude],
        longitude: @params[:longitude],
        location: @params[:location]
      }
    end

    def request_message
      {
        method: METHOD,
        url: url,
        headers: headers,
        timeout: 10
      }
    end

    def url
      "#{@config[:host]}#{PATH}"
    end

    def headers
      {
        authorization: "Bearer #{@config[:api_key]}",
        accept: :json,
        params: payload
      }
    end
  end
end
