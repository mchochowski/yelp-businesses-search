# frozen_string_literal: true

require 'spec_helper'

RSpec.describe YelpBusinessesSearch::Client do
  context 'with default host' do
    let(:api_key) { 'f4k3K3Y' }

    subject { described_class.new(api_key: api_key) }

    let(:query) { 'coffee' }
    let(:zip_code) { '10025' }
    let(:params) do
      {
        query: query,
        location: zip_code
      }
    end
    let(:expected_config) do
      {
        api_key: api_key,
        host: 'https://api.yelp.com/v3'
      }
    end
    let(:search_spy) { spy }

    describe '#lookup' do
      before do
        allow(YelpBusinessesSearch::SearchEndpoint).to receive(:new).with(params, expected_config)
                                                                    .and_return(search_spy)
      end

      it 'calls correct endpoint' do
        subject.lookup(params)
        expect(search_spy).to have_received(:call)
      end
    end
  end

  context 'with custom host' do
    let(:api_key) { 'f4k3K3Y' }

    subject { described_class.new(api_key: api_key, host: 'https://api.yelp.com/v4-preview') }

    let(:query) { 'coffee' }
    let(:zip_code) { '10025' }
    let(:params) do
      {
        query: query,
        location: zip_code
      }
    end
    let(:expected_config) do
      {
        api_key: api_key,
        host: 'https://api.yelp.com/v4-preview'
      }
    end
    let(:search_spy) { spy }

    describe '#lookup' do
      before do
        allow(YelpBusinessesSearch::SearchEndpoint).to receive(:new).with(params, expected_config)
                                                                    .and_return(search_spy)
      end

      it 'calls correct endpoint' do
        subject.lookup(params)
        expect(search_spy).to have_received(:call)
      end
    end
  end
end
