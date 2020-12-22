# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YelpBusinessesSearch::SearchEndpoint do
  subject { described_class.new(params, config) }

  let(:api_key) { 'f4k3K3Y' }
  let(:config) do
    {
      api_key: api_key,
      host: 'https://api.yelp.com/v3'
    }
  end
  let(:response_json) { File.read("#{File.dirname(__FILE__)}/files/example_search_response.json") }

  let(:query) { 'coffee' }
  let(:zip_code) { '10025' }
  let(:params) do
    {
      query: query,
      location: zip_code
    }
  end

  context 'with request not executed' do
    it 'builds request correct url' do
      expect(RestClient::Request).to receive(:execute)
        .with(hash_including(url: 'https://api.yelp.com/v3/businesses/search'))
      subject.call
    end

    it 'builds request payload with correct search term param' do
      expect(RestClient::Request).to receive(:execute)
        .with(hash_including(headers: hash_including(params: hash_including(term: query))))
      subject.call
    end

    it 'builds request payload with correct location param' do
      expect(RestClient::Request).to receive(:execute)
        .with(hash_including(headers: hash_including(params: hash_including(location: zip_code))))
      subject.call
    end

    it 'builds correct auth header' do
      expect(RestClient::Request).to receive(:execute)
        .with(hash_including(headers: hash_including(authorization: "Bearer #{api_key}")))
      subject.call
    end
  end

  context 'with request succesfully executed' do
    before do
      stub_request(:get, 'https://api.yelp.com/v3/businesses/search?'\
                         "latitude&location=#{zip_code}&longitude&term=#{query}")
        .to_return(status: 200, body: response_json)
    end

    it 'is correctly stubbed' do
      expect { subject.call }.to_not raise_error
    end

    it "returns yelp's response" do
      expect(subject.call).to eq response_json
    end
  end

  context 'with failing request' do
    before do
      stub_request(:get, 'https://api.yelp.com/v3/businesses/search?'\
                         "latitude&location=#{zip_code}&longitude&term=#{query}")
        .to_return(status: 429, body: {
          error: {
            code: 'ACCESS_LIMIT_REACHED',
            description: "You've reached the access limit for this client"
          }
        }.to_json)
    end

    it 'catches the exception' do
      expect { subject.call }.to_not raise_error
    end

    it 'returns error message' do
      response = JSON.parse(subject.call)
      expect(response['error']).to eq('error connecting to yelp')
      expect(response['original_response']['error']['code']).to eq('ACCESS_LIMIT_REACHED')
    end
  end
end
