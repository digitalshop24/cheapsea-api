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
end
