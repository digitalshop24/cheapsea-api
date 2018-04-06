require 'rails_helper'

describe Airlines::GetAllService do
  subject { Airlines::GetAllService.call }

  use_vcr_cassette 'services/airlines/get_all_service'

  it 'checks that result is not empty' do
    expect(subject).not_to be_nil
  end

  it 'checks that result is an array' do
    expect(subject).to be_a(Array)
  end
end
