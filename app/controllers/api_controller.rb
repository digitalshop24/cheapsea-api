class ApiController < ApplicationController
  Swagger::Docs::Generator::set_real_methods
  include Swagger::Docs::ImpotentMethods

  class << self
    Swagger::Docs::Generator::set_real_methods
  end

  def self.credentials(api)
    api.param :header, 'uid', :string, :required, 'uid'
    api.param :header, 'access-token', :string, :required, 'access-token'
    api.param :header, 'client', :string, :required, 'client'
  end
end