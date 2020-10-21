# frozen_string_literal: true

module Commands
  class Base < BaseAction
    COMMANDS = { start: '/start', get_all: '/get_all', help: '/help',
                 about: '/about', create_currency: '/create_currency', update_currency: '/update_currency',
                 delete_currency: '/delete_currency' }.freeze

    def initialize(args)
      super(args)
      define_params
    end

    private

    attr_reader :webhook, :from, :bot

    def define_params
      @from = webhook.from
      @bot = webhook.bot
      @chat = webhook.chat
      @payload = webhook.payload
      @update = webhook.update
    end

    def find_currency
      currency_id ||= webhook.payload['data']&.split('/').last&.to_i
      @currency = Currency.find_by(id: currency_id)
    end

    def currencies
      @currencies ||= Currency.all
    end

    def start_keyboard_markup
      { inline_keyboard:
          [
            [{ text: I18n.t('help_button'), callback_data: COMMANDS[:help] },
             { text: I18n.t('get_all_button'), callback_data: COMMANDS[:get_all] }],
            [{ text: I18n.t('create_currency_button'), callback_data: COMMANDS[:create_currency] }],
            [{ text: I18n.t('update_currency_button'), callback_data: COMMANDS[:update_currency] }],
            [{ text: I18n.t('delete_currency_button'), callback_data: COMMANDS[:delete_currency] }]
          ] }
    end

    def get_all_keyboard_markup(action = 'details')
      { inline_keyboard: currencies.map { |c| [{ text: c.symbol, callback_data: "/#{action}/#{c.id}" }] } }
    end

    def all_set?
      webhook.session[:currency].all? { |_k, v| v.present? }
    end

    def reset_session
      webhook.session[:currency] = nil
    end

    def parse_input(current_param)
      input = webhook.payload['text']
      return input unless %i[bid ask].include?(current_param)

      parsed = input.split('/')
      { price: parsed.first, size: parsed.last }
    end
  end
end
