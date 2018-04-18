require 'rails_helper'

describe ConvertService do
  let(:object) { nil }

  describe 'remove_params_from_array_with_hash' do
    subject do
      ConvertService.remove_params_from_array_with_hash(object, %w[id airline_id])
    end

    let(:object) { [{"id"=>"51", "google_place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g", "airline_id"=>"1"}] }

    it 'checks that keys were deleted' do
      expect(subject).to eq([{"google_place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g"}])
    end
  end

  describe 'remove_params_from_array' do
    subject do
      ConvertService.remove_params_from_array(object, %w[name discount_type])
    end

    let(:object) { %w[offer_type discount_type name] }

    it 'checks that keys were deleted' do
      expect(subject).to eq(%w[offer_type])
    end
  end
end
