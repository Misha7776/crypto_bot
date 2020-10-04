# frozen_string_literal: true

module Requests
  class CreateCurrency < Requests::Base
    def call
      self.class.post('/currencies', body: params)
    end
  end
end
