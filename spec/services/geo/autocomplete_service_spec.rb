require 'rails_helper'

describe Geo::AutocompleteService do
  subject { Geo::AutocompleteService.new(input).call }

  let(:input) { 'New York' }

  context 'found' do
    use_vcr_cassette 'services/geo/autocomplete/found'

    it 'checks that result is not nil' do
      expect(subject).not_to be_nil
    end

    it 'checks that the city has found' do
      expect(subject.first['description']).to eq('New York, NY, USA')
    end
  end

  context 'not found' do
    use_vcr_cassette 'services/geo/autocomplete/not_found'

    let(:input) { 'djshfg3487fg874' }

    it 'checks that result is empty' do
      expect(subject).to be_empty
    end
  end
end
