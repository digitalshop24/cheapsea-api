require 'rails_helper'

describe ThirdParty::Geo::AutocompleteService do
  subject { ThirdParty::Geo::AutocompleteService.call(input: input) }

  let(:input) { 'New York' }

  context 'found' do
    use_vcr_cassette 'services/geo/autocomplete/found'

    it 'checks that service successed' do
      expect(subject.success?).to eq true
    end

    it 'checks that the city has found' do
      expect(subject.result.first['description']).to eq('New York, NY, USA')
    end
  end

  context 'not found' do
    use_vcr_cassette 'services/geo/autocomplete/not_found'

    let(:input) { 'djshfg3487fg874' }

    it 'checks that result is empty' do
      expect(subject.result).to be_empty
    end
  end
end
