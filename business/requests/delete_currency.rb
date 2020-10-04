# frozen_string_literal: true

module Requests
  class DeleteCurrency < Requests::Base
    def call
      self.class.delete("/currencies/#{params[:currency][:id]}")
    end
  end
end
