# frozen_string_literal: true

module Commands
  class Start < Commands::Base
    def call
      { text: reply_text,
        reply_markup: start_keyboard_markup }
    end

    private

    def reply_text
      webhook.from ? I18n.t('hello', { username: webhook.from['username'] }) : I18n.t('anonymous_hello')
    end
  end
end
