# frozen_string_literal: true

module Commands
  class CreateCurrency < Commands::Base
    include Telegram::Bot::UpdatesController::Session

    def call
      return enter_name if webhook.session[:currency].blank?
      return set_name if webhook.session[:currency][:name].blank?

      set_symbol if webhook.session[:currency][:symbol].blank?
      save_currency
    end

    private

    attr_reader :currency

    def enter_name
      webhook.session[:currency] ||= { name: '', symbol: '' }
      webhook.save_next_step :create_currency!
      { text: I18n.t('enter_name') }
    end

    def set_name
      webhook.session[:currency][:name] = webhook.payload['text']
      webhook.save_next_step :create_currency!
      { text: I18n.t('enter_symbol') }
    end

    def set_symbol
      webhook.session[:currency][:symbol] = webhook.payload['text']
    end

    def save_currency
      response = Requests::CreateCurrency.call(params: webhook.session)
      reset_session
      if response.success?
        { text: I18n.t('currency_save'),
          reply_markup: start_keyboard_markup }
      else
        { text: response['errors'] }
      end
    end
  end
end
