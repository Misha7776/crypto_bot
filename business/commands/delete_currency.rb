# frozen_string_literal: true

module Commands
  class DeleteCurrency < Commands::Base
    def call
      find_currency
      return select_currency if currency.blank?

      delete_currency
      response_message
    end

    private

    attr_reader :currency, :response_message

    def select_currency
      { text: I18n.t('what_to_delete'),
        reply_markup: get_all_keyboard_markup('delete_currency') }
    end

    def delete_currency
      response = Requests::DeleteCurrency.call(params: { currency: { id: currency.id } })
      @response_message = if response.success?
                            { text: I18n.t('currency_updated'), reply_markup: start_keyboard_markup }
                          else
                            { text: response['errors'] }
                          end
    end
  end
end
