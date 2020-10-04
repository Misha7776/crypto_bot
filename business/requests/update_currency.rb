# frozen_string_literal: true

module Requests
  class UpdateCurrency < Requests::Base
    def call
      self.class.patch("/currencies/#{params[:currency][:id]}", body: params)
    end
  end
end
