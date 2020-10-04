# frozen_string_literal: true

module Requests
  class Base < BaseAction
    include HTTParty
    base_uri 'localhost:3000'

    private

    attr_reader :params
  end
end
