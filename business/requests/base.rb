# frozen_string_literal: true

module Requests
  class Base < BaseAction
    include HTTParty
    base_uri ENV.fetch('CRYPTO_API_HOST', RCreds.fetch(:api_url))

    private

    attr_reader :params
  end
end
