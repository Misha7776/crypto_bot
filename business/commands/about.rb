# frozen_string_literal: true

module Commands
  class About < Commands::Base
    def call
      { text: I18n.t('about_text'),
        reply_markup: reply_keyboard_markup }
    end

    private

    def reply_keyboard_markup
      { inline_keyboard:
        [
          [{ text: I18n.t('get_all_button'), callback_data: COMMANDS[:get_all] }]
        ] }
    end
  end
end
