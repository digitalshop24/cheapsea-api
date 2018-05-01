require 'rails_helper'

describe Filters::CitiesFilter do
  subject { Filters::CitiesFilter.new(query).call }

  before do
    @active_city = create(:city, active: true)
    @main_city = create(:city, active: false, name: 'Нью-Йорк', name_en: 'New York')
  end

  context 'empty query' do
    let(:query) { '' }

    it 'checks that result is not empty' do
      expect(subject).not_to be_empty
    end

    it 'checks that result is active city' do
      expect(subject.first).to eq(@active_city)
    end
  end

  context 'record found in the database' do
    context 'name' do
      let(:query) { 'Нью-Йорк' }

      it 'checks that result is main city' do
        expect(subject.first).to eq(@main_city)
      end
    end

    context 'name_en' do
      let(:query) { 'New York' }

      it 'checks that result is main city' do
        expect(subject.first).to eq(@main_city)
      end
    end
  end

  context 'record not found in the database' do
    context 'found in the google api' do
      use_vcr_cassette 'queries/filters/cities_filter_service/found'

      let(:query) { 'Фрязино' }

      it 'checks that result found via the google api' do
        expect(subject.first[:google_places]).not_to be_empty
      end
    end

    context 'found in the google api' do
      use_vcr_cassette 'queries/filters/cities_filter_service/not_found'

      let(:query) { '3d299h39823hd' }

      it 'checks that result found via the google api' do
        expect(subject.first[:google_places]).to be_empty
      end
    end
  end
end
