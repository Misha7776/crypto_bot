# frozen_string_literal: true

module Commands
  class Detail < Commands::Base
    def call
      find_currency
      { text: currency_details,
        parse_mode: 'HTML',
        reply_markup: reply_keyboard_markup }
    end

    private

    attr_reader :currency

    def currency_details
      ["<b>Name:</b> #{currency.name}",
       "<b>Symbol:</b> #{currency.symbol}",
       "<b>ASK:</b> \t Price: <b>#{currency.ask[0]&.dig('price') || 0.0}</b>
          \tSize: <b>#{currency.ask[0]&.dig('size') || 0.0}</b>",
       "<b>BID:</b> Price: <b>#{currency.bid[0]&.dig('price') || 0.0}</b>
          \tSize: <b>#{currency.bid[0]&.dig('size') || 0.0}</b>",
       "<b>Traded At:</b> #{currency.traded_at}"].join("\n")
    end

    def reply_keyboard_markup
      { inline_keyboard:
        [
          [{ text: I18n.t('change_log_button', currency: currency.symbol), callback_data: "/change_log/#{currency.id}" }]
        ] }
    end
  end
end
