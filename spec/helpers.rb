module Helpers
  def sign_in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return user
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return true
  end
end
