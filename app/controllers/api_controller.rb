class ApiController < ApplicationController
  Swagger::Docs::Generator::set_real_methods
  include Swagger::Docs::ImpotentMethods

  class << self
    Swagger::Docs::Generator::set_real_methods
  end

  def self.credentials(api)
    api.param :header, 'Authorization', :string, :required, 'ex: Bearer token'
  end
end
