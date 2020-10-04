# frozen_string_literal: true

module Commands
  class ChangeLog < Commands::Base
    include Events

    def call
      find_currency
      details = currency_details
      { text: details.present? ? details : I18n.t('change_log_empty'),
        parse_mode: 'HTML' }
    end

    private

    attr_reader :currency

    def read_stream
      Rails.configuration.event_store.read.backward.limit(10).stream("Domain::Currency$#{currency.id}").to_a
    end

    def currency_details
      read_stream.map do |event|
        ["<b>Symbol:</b> #{event.data[:symbol]}",
         "<b>ASK:</b> \t Price: <b>#{event.data[:ask].try(:[], 0)&.dig('price') || 0.0}</b>
          \tSize: <b>#{event.data[:ask].try(:[], 0)&.dig('size') || 0.0}</b>",
         "<b>BID:</b> \t Price: <b>#{event.data[:bid].try(:[], 0)&.dig('price') || 0.0}</b>
          \tSize: <b>#{event.data[:bid].try(:[], 0)&.dig('size') || 0.0}</b>",
         "<b>Traded At:</b> #{event.data[:traded_at]}"].join("\n")
      end.join("\n----------------------------\n")
    end
  end
end
